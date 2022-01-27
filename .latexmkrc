# vi: ft=config
@default_files = ( 'main.tex' );

$jobname = 'main';
$pdflatex = 'pdflatex -synctex=1 -file-line-error -halt-on-error -interaction=nonstopmode';
$out_dir = 'build';
$aux_dir = 'build';
