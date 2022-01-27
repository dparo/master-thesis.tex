.DEFAULT_GOAL := all
.PHONY: all release clean svg2pdf

SVGS := $(shell find ./Imgs -type f -name '*.svg')
SVGS_AS_PDFS := $(patsubst %.svg, %.out.pdf, $(SVGS))

BUILD_DIR:=./build

all: $(BUILD_DIR)/main.pdf
release: $(BUILD_DIR)/Release.pdf
clean:
	# Clean generated pdfs
	find ./Imgs -type f -name "*.out.pdf" -exec rm -rf {} \;
	# Clean latexmk files
	latexmk -c
	# Remove build directory
	rm -rf build

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


svg2pdf: $(SVGS_AS_PDFS)

%.out.pdf: %.svg
	inkscape --export-overwrite --export-type=pdf --export-filename=$@ $<



$(BUILD_DIR)/main.pdf: $(BUILD_DIR) svg2pdf
	latexmk -pdf


$(BUILD_DIR)/Release.pdf: $(BUILD_DIR)/main.pdf
	# Compress and Convert into PDF/A using ghostscript
	gs -dNOPAUSE -dQUIET -dBATCH \
		-dPDFSETTINGS=/prepress \
		-dPDFA=1 -sColorConversionStrategy=RGB -dPDFACompatibilityPolicy=2 \
		-sDEVICE=pdfwrite -sOutputFile=$(BUILD_DIR)/Release.pdf $(BUILD_DIR)/main.pdf

	# Show pdf files of the original uncompressed file and the new compressed one
	du --all -hc -d 1 $(BUILD_DIR)/main.pdf $(BUILD_DIR)/Release.pdf
