#!/usr/bin/env perl

# =============================================================================
# LaTeX Template - latexmk設定ファイル
# =============================================================================
# このファイルは、LaTeXテンプレート用のlatexmk設定です。
# 外付けSSDのTeX Liveを使用する場合は、環境変数でパスを設定してください：
#
# export PATH="/mnt/d/texlive/2025/bin/x86_64-linux:$PATH"
# または
# export PATH="/mnt/e/texlive/2025/bin/x86_64-linux:$PATH"
#
# 設定後は、latexmkやlualatexなどのコマンドが外付けSSDのTeX Liveを使用します。
# =============================================================================

# LuaLaTeX コンパイルの設定
$latex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
$pdflatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';

# bibtexコマンド: 環境変数で設定するためデフォルトを使用
$bibtex_use = 2;   # bibtex を強制実行
$makeindex = 'makeindex %O -o %D %S';
$max_repeat = 10;
$pdf_mode = 4; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx, 4: lualatex

# ビルドディレクトリの設定
$aux_dir = 'temp';
$out_dir = 'temp';

# 必要なディレクトリを自動作成
system('mkdir -p temp bib ../build/pdf ../build/docx ../build/csv');

# 中間ファイルの削除設定（BibTeX用）
$clean_ext = 'aux bbl blg idx ilg ind lof lot out toc acn acr alg glg glo gls fls log fdb_latexmk dvi';

# 環境変数の設定
$ENV{'TEXINPUTS'} = '.://:' . ($ENV{'TEXINPUTS'} || '');
$ENV{'BIBINPUTS'} = './bib//:' . ($ENV{'BIBINPUTS'} || '');
$ENV{'BSTINPUTS'} = '.://:' . ($ENV{'BSTINPUTS'} || '');

# クリーンアップ設定
$cleanup_mode = 0;

# bibtex実行（標準のBibTeX処理）
$bibtex = 'bibtex %O %B';

# 処理完了後のフック：成果物の移動
$END_HOOK = sub {
    my $base_name = $ARGV[0];
    $base_name =~ s/\.tex$//;
    
    print "🔍 Moving output files for $base_name...\n";
    
    # PDFファイルをプロジェクトルート/build/pdfに移動
    if (-f "$base_name.pdf") {
        system('mkdir -p ../build/pdf');
        system("cp $base_name.pdf ../build/pdf/");
        print "✅ Copied PDF to ../build/pdf/\n";
    }
    
    # .bblファイルを保持（必要に応じて）
    if (-f "$base_name.bbl") {
        system('mkdir -p bib');
        system("cp $base_name.bbl bib/");
        print "✅ Copied BBL to tex/bib/\n";
    }
    
    # 一時ファイルのクリーンアップ（重要なファイルは保持）
    print "🧹 Cleaning up temporary files...\n";
    my @temp_files = qw(aux log blg synctex.gz);
    foreach my $ext (@temp_files) {
        my @files = glob("*.$ext");
        foreach my $file (@files) {
            if (unlink($file)) {
                print "🗑️ Removed $file\n";
            }
        }
    }
    
    print "✨ Cleanup completed!\n";
};

# XeLaTeX を使用する場合（コメントアウト）
# $latex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# LuaLaTeX を使用する場合（コメントアウト）
# $latex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx 