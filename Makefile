.DEFAULT_GOAL := all
.PHONY: all release clean svg2pdf

SVGS := $(wildcard Imgs/**/*.svg)
PDFIMGS := $(patsubst %.svg, %.pdf, $(SVGS))

BUILD_DIR:=./build
LATEXMK_FLAGS=-silent -pdf -file-line-error -halt-on-error -interaction=batchmode -auxdir=$(BUILD_DIR) -outdir=$(BUILD_DIR)
LATEXMK=latexmk $(LATEXMK_FLAGS)

all: $(BUILD_DIR)/main.pdf
release: $(BUILD_DIR)/Release.pdf
clean:
	$(LATEXMK) -c


# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

svg2pdf: $(PDFIMGS)

%.pdf: %.svg
	inkscape --export-overwrite --export-type=pdf $@ -o $<

$(BUILD_DIR)/main.pdf: $(BUILD_DIR) svg2pdf
	$(LATEXMK) -pdf main.tex


$(BUILD_DIR)/Release.pdf: $(BUILD_DIR)/main.pdf
	# Compress and Convert into PDF/A using ghostscript
	gs -dNOPAUSE -dQUIET -dBATCH \
		-dPDFSETTINGS=/prepress \
		-dPDFA -sColorConversionStrategy=RGB -dPDFACompatibilityPolicy=2 \
		-sDEVICE=pdfwrite -sOutputFile=$(BUILD_DIR)/Release.pdf $(BUILD_DIR)/main.pdf

	# Show pdf files of the original uncompressed file and the new compressed one
	du --all -hc -d 1 $(BUILD_DIR)/main.pdf $(BUILD_DIR)/Release.pdf
