.PHONY: all

SVGS := $(wildcard Imgs/**/*.svg)
PDFIMGS := $(patsubst %.svg, %.pdf, $(SVGS))

BUILD_DIR:=./build
LATEXMK_FLAGS=-pdf -file-line-error -halt-on-error -interaction=nonstopmode -auxdir=$(BUILD_DIR) -outdir=$(BUILD_DIR)

all: svg2pdf
	mkdir -p build
	latexmk -pdf $(LATEXMK_FLAGS) main.tex

clean:
	latexmk -c $(LATEXMK_FLAGS)


svg2pdf: $(PDFIMGS)

%.pdf: %.svg
	inkscape --export-overwrite --export-type=pdf $@ -o $<
