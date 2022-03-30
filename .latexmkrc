# vi: ft=config
@default_files = ( 'main.tex' );

$jobname = 'build';
$success_cmd = 'cp build/%R.pdf build/main.pdf';
$pdflatex = 'pdflatex -synctex=1 -file-line-error -halt-on-error -interaction=nonstopmode';
$out_dir = './build';
$aux_dir = './build';



# Support for glossary
################################################
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeindex -s '$_[0]'.ist -t '$_[0]'.glg -o '$_[0]'.gls '$_[0]'.glo");
}
#################################################
