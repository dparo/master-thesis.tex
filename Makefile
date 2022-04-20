.DEFAULT_GOAL := all
.PHONY: all release clean hard_clean watch spellcheck svg2pdf prebuild

export PRINT= n


BUILD_DIR:=./build
STUDENT_NAME:=Paro_Davide
RELEASE_PDF:=$(BUILD_DIR)/$(STUDENT_NAME).pdf


SVGS := $(shell find ./Imgs -type f -name '*.svg')
SVGS_AS_PDFS := $(patsubst %.svg, %.out.pdf, $(SVGS))
PDFS := $(shell find ./Imgs -type f -name '*.pdf' | grep -v ".cropped.")
PDFS_CROPPED := $(patsubst %.pdf, %.cropped.pdf, $(PDFS))


all: $(BUILD_DIR)/main.pdf
release: spellcheck all $(RELEASE_PDF)
clean:
	# Clean latexmk files
	latexmk -c

hard_clean: clean
	# Clean generated pdfs
	find ./Imgs -type f -name "*.out.pdf" -exec rm -rf {} \;
	find ./Imgs -type f -name "*.cropped.pdf" -exec rm -rf {} \;
	rm -rf build



# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


watch:
	latexmk -pdf -pvc -view=none

svg2pdf: $(SVGS_AS_PDFS)

croppdfs: $(PDFS_CROPPED)

%.out.pdf: %.svg
	inkscape --export-area-drawing --export-dpi=600 --export-overwrite --export-type=pdf --export-filename="$@" "$<"

%.cropped.pdf: %.pdf
	pdfcrop "$<" "$@"



prebuild: $(BUILD_DIR) svg2pdf croppdfs

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
