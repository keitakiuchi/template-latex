#!/usr/bin/env perl

# =============================================================================
# 外付けSSDのTeX Liveを使用する場合の設定
# =============================================================================
# 外付けSSD（D:ドライブ）にTeX Liveがインストールされている場合は、
# 以下のコマンドで.bashrcにパスを設定してください：
#
# echo 'export PATH="/mnt/d/texlive/2025/bin/x86_64-linux:$PATH"' >> ~/.bashrc
# source ~/.bashrc
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

# ビルドディレクトリの設定（tex/ディレクトリ内でコンパイル）
$aux_dir = '';
$out_dir = '';

# ビルドディレクトリを自動作成（プロジェクトルートのみ）
system('mkdir -p ../build/pdf tex/bib');

# 中間ファイルの削除設定（BibTeX用）
$clean_ext = 'aux bbl blg idx ilg ind lof lot out toc acn acr alg glg glo gls fls log fdb_latexmk dvi';

# 環境変数の設定（tex/ディレクトリ内での作業用）
$ENV{'TEXINPUTS'} = '.://:' . ($ENV{'TEXINPUTS'} || '');
$ENV{'BIBINPUTS'} = './bib//:' . ($ENV{'BIBINPUTS'} || '');
$ENV{'BSTINPUTS'} = '.://:' . ($ENV{'BSTINPUTS'} || '');

# クリーンアップ設定
$cleanup_mode = 0;

# bibtex実行（標準のBibTeX処理）
$bibtex = 'bibtex %O %B';

# 処理完了後のフック：成果物の移動
$END_HOOK = sub {
    print "🔍 Moving output files...\n";
    
    # PDFファイルをプロジェクトルート/build/pdfに移動
    if (-f 'JPR_LLM_evaluation.pdf') {
        system('mkdir -p ../build/pdf');
        system('cp JPR_LLM_evaluation.pdf ../build/pdf/');
        print "✅ Copied PDF to ../build/pdf/\n";
    }
    
    # .bblファイルを保持（必要に応じて）
    if (-f 'JPR_LLM_evaluation.bbl') {
        system('cp JPR_LLM_evaluation.bbl bib/');
        print "✅ Copied BBL to tex/bib/\n";
    }
    
    # 一時ファイルのクリーンアップ
    print "🧹 Cleaning up temporary files...\n";
    my @temp_files = qw(aux log blg synctex.gz bbl pdf);
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

# XeLaTeX を使用する場合
# $latex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# LuaLaTeX を使用する場合
# $latex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx 