#!/usr/bin/env perl

# LuaLaTeX コンパイルの設定
$latex = 'lualatex -synctex=1 -halt-on-error -file-line-error -interaction=nonstopmode %O %S';
$pdflatex = 'lualatex -synctex=1 -halt-on-error -file-line-error -interaction=nonstopmode %O %S';
$bibtex = 'biber %O %B';
$makeindex = 'makeindex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# ビルドディレクトリの設定
$aux_dir = './build';
$out_dir = './build';

# ビルドディレクトリを自動作成
system('mkdir -p ./build');

# 中間ファイルの削除設定
$clean_ext = 'aux bbl bcf blg idx ilg ind lof lot out run.xml toc acn acr alg glg glo gls fls log fdb_latexmk dvi';

# 環境変数の設定
$ENV{'TEXINPUTS'} = './/:' . $ENV{'TEXINPUTS'};
$ENV{'BIBINPUTS'} = './/:' . $ENV{'BIBINPUTS'};
$ENV{'BSTINPUTS'} = './/:' . $ENV{'BSTINPUTS'};

# XeLaTeX を使用する場合
# $latex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# LuaLaTeX を使用する場合
# $latex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx 