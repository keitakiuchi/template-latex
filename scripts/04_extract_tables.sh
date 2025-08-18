#!/usr/bin/env bash
# 04_extract_tables.sh — LaTeX table / longtable → UTF‑8 CSV
# ------------------------------------------------------------------
# 2025‑09‑02  FULL‑PATCH
#   • \% をコメント扱いしない（ヘッダー欠落バグ修正）
#   • Score 表以外ではサブヘッダー行を除去しない
#   • 1 列目が空でも current_score を埋める
#   • 列数不足時に空文字でパディング
# ------------------------------------------------------------------

set -euo pipefail
export LC_ALL=C.UTF-8

if [ $# -ne 1 ]; then
  echo "使い方: $0 tex/ファイル名.tex" >&2
  exit 1
fi

TEXFILE="$1"
BASENAME=$(basename "$TEXFILE" .tex)
TEXDIR=$(dirname "$TEXFILE")
CSVOUTDIR="../build/csv"

cd "$TEXDIR"
mkdir -p "$CSVOUTDIR"

TEMP_AWK=$(mktemp)
trap 'rm -f "$TEMP_AWK"' EXIT

cat > "$TEMP_AWK" <<'AWK_SCRIPT'
BEGIN{
  in_table=in_tabular=in_notes=0; auto_table=0
  table_count=row_count=max_cols=0
  split("",table_data)
  note_text=current_score=""
  header_saved=super_saved=0
  header_cols=super_cols=0
  split("",header_data); split("",super_data)
  row_buf=""; after_toprule=0; pval_col=0
  Q = 39   # "'" (アポストロフィ)
}

############ table 開始・終了 ############
/\\begin\{table\}/          {init_table(0);next}
/\\begin\{longtable\}/      {if(!in_table)init_table(1);in_tabular=1;next}
/\\begin\{tabular\}|\\begin\{tabularx\}/ {if(in_table)in_tabular=1;next}
/\\end\{tabular\}|\\end\{tabularx\}/     {in_tabular=0;next}
/\\end\{longtable\}/        {in_tabular=0;if(auto_table){output_csv();reset_table()} next}
/\\end\{table\}/            {if(in_table){output_csv();reset_table()} next}

############ tablenotes ############
/\\begin\{tablenotes\}/ {in_notes=1;next}
in_notes&&/\\end\{tablenotes\}/ {in_notes=0;next}
in_notes{
  raw=$0
  label=""
  if(match(raw,/\\item(\[([^\]]+)\])?[[:space:]]*/,m)){
     label=m[2]; sub(/^.*\\item(\[[^]]*\])?[[:space:]]*/,"",raw)
  }
  text=cleanup(raw)
  if(text){
     if(note_text) note_text=note_text" "
     if(label)     note_text=note_text label" "
     note_text=note_text text
  }
  next
}

############ multicolumn 見出し即時検出 ############
in_tabular && /\\multicolumn\{/ && after_toprule {
  # toprule直後のmulticolumn行はスーパーヘッダー候補なのでバッファリングへ
}

############ 行バッファリング ############
in_tabular{
  if($0~/^%/)            {row_buf=""; next}
  if($0~/\\toprule/)     {after_toprule=1;next}
  if($0~/\\midrule/)     {
    # longtableでは\midruleの後に\endfirstheadがある場合は継続
    if(!after_toprule || $0 !~ /\\midrule[[:space:]]*$/) after_toprule=0
    next
  }
  if($0~/\\endfirsthead/){after_toprule=0;next}
  if($0~/\\endhead/)     {after_toprule=0;next}
  if($0~/\\endfoot|\\endlastfoot|\\bottomrule/) next
  if($0~/\\c(m|l)idrule|\\cline/) next

  gsub(/^[ \t]+/,"",$0)
  row_buf=row_buf $0
  if(row_buf !~ /\\\\(\[[^]]*\]|[*])?[[:space:]]*$/) next

  process_row(row_buf)
  row_buf=""
  next
}

############ 行処理 ############
function process_row(line,   raw,parts,cols,tmp,c,n,is_super,is_header){
  gsub(/\\addlinespace/,"",line)

  # ---------- 行内コメント除去 ----------
  # コメント行は完全に除外（データ行の前にコメントがある場合）
  if(line ~ /^[[:space:]]*%/) return
  # 空白または行頭 % をコメントとみなす（\% は残す）
  line = gensub(/(^|[[:space:]])%.*$/, "\\1", 1, line)
  
  # DEBUG: Table 8のデバッグ
  if(current_table ~ /table_08/) {
    print "DEBUG T8: Processing line: " line >> "/tmp/debug_table8.log"
  }

  sub(/\\\\(\[[^]]*\]|[*])?[[:space:]]*$/,"",line)
  gsub(/\\c(m|l)idrule[^\\]*/,"",line)
  gsub(/\[[0-9.]+pt\]/,"",line)

  # ---------- multicolumn 展開 ----------
  raw=line; line=""
  while(match(raw,/\\multicolumn\{([0-9]+)\}\{[^}]+\}\{([^}]*)\}/,m)){
     n=m[1]; content=m[2]
     pre=substr(raw,1,RSTART-1); post=substr(raw,RSTART+RLENGTH)
     line=line pre content
     for(i=2;i<=n;i++) line=line "&"
     raw=post
  }
  line=line raw

  split(line,parts,/&/)
  n=length(parts)

  # ヘッダー確定後に列数が足りない場合は空で補完
  if(header_saved && n<header_cols){
     for(c=n+1;c<=header_cols;c++) parts[c]=""
     n=header_cols
  }

  # 数式 & cleanup
  split("",cols); for(c=1;c<=n;c++){
      x=parts[c]
      if(x~/^\$[^$]*\$$/){sub(/^\$/,"",x);sub(/\$$/,"",x);gsub(/\\!/,"",x)}
      cols[c]=cleanup(x)
  }

  # Score 列のキャリーオーバー（元の値を記録）
  original_first_col=cols[1]
  if(cols[1]!="")      current_score=cols[1]
  else if(current_score!="") cols[1]=current_score

  # ---------- スーパーヘッダー検出 ----------
  is_super = (!super_saved) && after_toprule && cleanup(cols[1])==""
  if(is_super){
     super_cols=n; for(c=1;c<=n;c++) super_data[c]=cols[c]
     super_saved=1; return
  }

  # ---------- ヘッダー検出 ----------
  is_header = (!header_saved) &&
              ((after_toprule && cleanup(cols[1])!="") ||
               (tolower(cols[1])=="score" && (tolower(cols[2])=="human" || tolower(cols[2])=="term" || tolower(cols[2])=="comparison")))
  if(is_header){
     header_cols=n; for(c=1;c<=n;c++){
        header_data[c]=cols[c]
        if(tolower(header_data[c])=="p value") pval_col=c
     }
     header_saved=1; after_toprule=0; return
  }
  if(!header_saved) return

  # DEBUG: Table 8のデバッグ - フィルタリング前
  if(current_table ~ /table_08/) {
    print "DEBUG T8: cols[1]='" cols[1] "', cleanup(cols[1])='" cleanup(cols[1]) "', current_score='" current_score "'" >> "/tmp/debug_table8.log"
  }
  
  # 不要行除外（実際のScoreヘッダー行のみ、キャリーオーバーで埋められた行は除外しない）
  if(original_first_col=="Score") return
  # 空行除外（全列が空の場合）
  all_empty=1; for(c=1;c<=n;c++) if(cleanup(cols[c])!="") {all_empty=0; break}
  if(all_empty) {
    if(current_table ~ /table_08/) print "DEBUG T8: Filtering out all_empty row" >> "/tmp/debug_table8.log"
    return
  }
  # Score 表のみ重複除去  
  if(tolower(header_data[1])=="score" && cols[1]==current_score && cols[2]=="") {
    if(current_table ~ /table_08/) print "DEBUG T8: Filtering out duplicate Score row" >> "/tmp/debug_table8.log"
    return
  }

  # ---------- データ格納 ----------
  ++row_count
  for(c=1;c<=n;c++) table_data[row_count","c]=cols[c]
  if(n>max_cols) max_cols=n
}

############ CSV 出力 ############
function output_csv(   f,i,j,line,cell){
  f=csv_dir"/"current_table".csv"

  if(super_saved){
    line=""; for(j=1;j<=super_cols;j++){
      if(j>1) line=line","
      cell=super_data[j]; if(cell~/[,\n\r]/){gsub(/"/,"\"\"",cell);cell="\""cell"\""}
      line=line cell
    } print line>f
  }
  if(header_saved){
    line=""; for(j=1;j<=header_cols;j++){
      if(j>1) line=line","
      cell=header_data[j]; if(cell~/[,\n\r]/){gsub(/"/,"\"\"",cell);cell="\""cell"\""}
      line=line cell
    } print line>f
  }

  for(i=1;i<=row_count;i++){
    line=""; for(j=1;j<=max_cols;j++){
      if(j>1) line=line","
      cell=table_data[i","j]
      if(j==pval_col && cell~/^[0-9.]+$/) cell=sprintf("%c%.3f",Q,cell+0)
      else if(cell~/^-?[0-9]+\.[0-9]+$/)  cell=sprintf("%c%.2f",Q,cell+0)
      if(cell~/[,\n\r]/){gsub(/"/,"\"\"",cell);cell="\""cell"\""}
      line=line cell
    } print line>f
  }

  if(note_text){
    print "" >> f
    nt=note_text; if(nt~/[,\n\r]/){gsub(/"/,"\"\"",nt);nt="\""nt"\""}
    print "Note," nt >> f
  }
  close(f)
}

############ 初期化 / 片付け ############
function init_table(a){
  in_table=1; auto_table=a; ++table_count
  current_table=sprintf("%s_table_%02d",basename,table_count)
  row_count=max_cols=0; split("",table_data)
  note_text=current_score=""
  header_saved=super_saved=0
  header_cols=super_cols=0
  split("",header_data); split("",super_data)
  row_buf=""; after_toprule=0; pval_col=0
}
function reset_table(){in_table=auto_table=0}

############ cleanup ############
function cleanup(t){
  gsub(/^\s+|\s+$/,"",t)
  gsub(/\$|\\\(|\\\)|\\\[|\\\]/,"",t)
  gsub(/\\%/,"%",t); gsub(/\\pm/,"+/-",t); gsub(/±/,"+/-",t)
  gsub(/\\le/,"<=",t);  gsub(/\\ge/,">=",t); gsub(/\\neq/,"!=",t)
  gsub(/\\approx/,"~",t); gsub(/\\times/,"x",t); gsub(/\\cdot/,".",t)
  gsub(/\\ldots/,"...",t)
  gsub(/\\textemdash/,"--",t); gsub(/\\textendash/,"-",t)
  gsub(/—/,"--",t); gsub(/–/,"-",t); gsub(/…/,"...",t)
  gsub(/‐|‑|‒|−/,"-",t); gsub(/\\!/,"",t)
  gsub(/``|''/,"",t); gsub(/\\tnote\{[^}]*\}/,"",t)
  t=gensub(/\\textbf\{([^}]*)\}/,"\\1","g",t)
  t=gensub(/\\textit\{([^}]*)\}/,"\\1","g",t)
  t=gensub(/\\emph\{([^}]*)\}/,"\\1","g",t)
  t=gensub(/\\text\{([^}]*)\}/,"\\1","g",t)
  gsub(/\\[A-Za-z]+/,"",t)
  gsub(/\\\./,".",t); gsub(/\\[ \t]/,"",t); gsub(/\\/,"",t)
  gsub(/\\\\(\[[^]]*\]|[*])?/,"",t); gsub(/\[[0-9.]+pt\]/,"",t)
  gsub(/\r|\n/,"",t); gsub(/[{}]/,"",t); gsub(/[ \t]+/," ",t)
  gsub(/"/,"",t)
  return t
}
AWK_SCRIPT

gawk -v csv_dir="$CSVOUTDIR" -v basename="$BASENAME" -f "$TEMP_AWK" "$BASENAME.tex"
echo "✅ CSV を ${CSVOUTDIR} に生成しました"
