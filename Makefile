.DEFAULT_GOAL := all
.PHONY: all release clean hard_clean watch spellcheck svg2pdf prebuild

export PRINT= n


BUILD_DIR:=./build
STUDENT_NAME:=Paro_Davide
TARGET_PDF :=$(BUILD_DIR)/$(STUDENT_NAME).pdf
OPTIMIZED_PDF :=$(BUILD_DIR)/$(STUDENT_NAME).optimized.pdf


SVGS := $(shell find ./Imgs -type f -name '*.svg')
SVGS_AS_PDFS := $(patsubst %.svg, %.out.pdf, $(SVGS))
PDFS := $(shell find ./Imgs -type f -name '*.pdf' | grep -v ".cropped.")
PDFS_CROPPED := $(patsubst %.pdf, %.cropped.pdf, $(PDFS))


all: $(TARGET_PDF)
release: spellcheck all $(OPTIMIZED_PDF)
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


validate: $(TARGET_PDF)
	$(info ---)
	$(info --- Validating PDF conformance to PDF/A-2b standard)
	$(info ---)
	verapdf -f 2b --format text -v $(TARGET_PDF)

prebuild: $(BUILD_DIR) svg2pdf croppdfs

$(TARGET_PDF): prebuild
	latexmk -pdf
	cp $(BUILD_DIR)/main.pdf $(TARGET_PDF)
	du -h $(TARGET_PDF)

spellcheck:
	find ./ -name "*.tex" -exec aspell --mode=tex --encoding=utf-8 --lang=en --add-extra-dicts=./dictionary.en.pws check "{}" \;

$(OPTIMIZED_PDF): $(TARGET_PDF)
	# Compress and Convert into PDF/A using ghostscript
	gs -dNOPAUSE -dQUIET -dBATCH \
		-dPDFSETTINGS=/prepress \
		-dPDFA=1 -sColorConversionStrategy=RGB -dPDFACompatibilityPolicy=2 \
		-sDEVICE=pdfwrite -sOutputFile=$(OPTIMIZED_PDF) $(TARGET_PDF)

	# Show pdf files of the original uncompressed file and the new compressed one
	du --all -hc -d 1 $(TARGET_PDF) $(OPTIMIZED_PDF)
