.PHONY: all

SVGS := $(wildcard Imgs/**/*.svg)
PDFIMGS := $(patsubst %.svg, %.pdf, $(SVGS))

BUILD_DIR:=./build
LATEXMK_FLAGS=-silent -pdf -file-line-error -halt-on-error -interaction=batchmode -auxdir=$(BUILD_DIR) -outdir=$(BUILD_DIR)

all: svg2pdf
	mkdir -p build
	latexmk -pdf $(LATEXMK_FLAGS) main.tex

release: all
	# Compress PDF using ghostscript
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=Release.pdf $(BUILD_DIR)/main.pdf
	# Show final Release pdf size
	du --all -hc -d 1 build/main.pdf Release.pdf

clean:
	latexmk -c $(LATEXMK_FLAGS)


svg2pdf: $(PDFIMGS)

%.pdf: %.svg
	inkscape --export-overwrite --export-type=pdf $@ -o $<
