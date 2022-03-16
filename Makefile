.DEFAULT_GOAL := all
.PHONY: all release clean hard_clean watch spellcheck svg2pdf prebuild

export PRINT= n


BUILD_DIR:=./build
STUDENT_NAME:=Paro_Davide
RELEASE_PDF:=$(BUILD_DIR)/$(STUDENT_NAME).pdf


SVGS := $(shell find ./Imgs -type f -name '*.svg')
SVGS_AS_PDFS := $(patsubst %.svg, %.out.pdf, $(SVGS))


all: $(BUILD_DIR)/main.pdf
release: spellcheck all $(RELEASE_PDF)
clean:
	# Clean generated pdfs
	find ./Imgs -type f -name "*.out.pdf" -exec rm -rf {} \;
	# Clean latexmk files
	latexmk -c

hard_clean: clean
	# Remove build directory
	rm -rf build

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


watch:
	latexmk -pdf -pvc -view=none

svg2pdf: $(SVGS_AS_PDFS)

%.out.pdf: %.svg
	inkscape --export-overwrite --export-type=pdf --export-filename=$@ $<



prebuild: $(BUILD_DIR) svg2pdf

$(BUILD_DIR)/main.pdf: prebuild
	latexmk -pdf

spellcheck:
	find ./ -name "*.tex" -exec aspell --mode=tex --encoding=utf-8 --lang=en --add-extra-dicts=./dictionary.en.pws check "{}" \;

$(RELEASE_PDF): $(BUILD_DIR)/main.pdf
	# Compress and Convert into PDF/A using ghostscript
	gs -dNOPAUSE -dQUIET -dBATCH \
		-dPDFSETTINGS=/prepress \
		-dPDFA=1 -sColorConversionStrategy=RGB -dPDFACompatibilityPolicy=2 \
		-sDEVICE=pdfwrite -sOutputFile=$(RELEASE_PDF) $(BUILD_DIR)/main.pdf

	# Show pdf files of the original uncompressed file and the new compressed one
	du --all -hc -d 1 $(BUILD_DIR)/main.pdf $(RELEASE_PDF)
