#!/usr/bin/env perl

# LaTeX コンパイルの設定
$latex = 'platex -synctex=1 -halt-on-error -file-line-error %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# ビルドディレクトリの設定
$aux_dir = './build';
$out_dir = './build';

# 中間ファイルの削除設定
$clean_ext = 'aux bbl blg idx ind lof lot out toc acn acr alg glg glo gls fls log fdb_latexmk dvi';

# XeLaTeX を使用する場合
# $latex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx

# LuaLaTeX を使用する場合
# $latex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdflatex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
# $pdf_mode = 1; # 0: no pdf, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx 