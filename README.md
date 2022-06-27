![GitHub release (latest by date)](https://img.shields.io/github/v/release/dparo/master-thesis.tex?style=for-the-badge) ![GitHub](https://img.shields.io/github/license/dparo/master-thesis.tex?style=for-the-badge) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dparo/master-thesis.tex/CI?style=for-the-badge)

# A Branch-and-Cut based Pricer algorithm for tackling the Capacitated Vehicle Routing Problem

This repository contains the LaTeX source code for the master degree thesis
in Computer Engineering of Davide Paro, presented at the University of Padua
in Year 2022.

The associated C source code implementation can be found at this [Github repo](https://github.com/dparo/master-thesis).

## :closed_book: Reading the prebuilt PDF Document

<!---
Prebuilt PDF download URL:
    https://github.com/dparo/master-thesis.tex/releases/latest/download/Paro_Davide.pdf
-->

<div>
<a href="https://dparo.github.io/documents/MSc_Paro_Davide.pdf" target="_blank" rel="noopener noreferrer">
<img src="https://img.shields.io/badge/-Get%20PDF%20Document-0a4026?style=for-the-badge&logo=firefox" alt="Get PDF Document" />
</a>
</div>
<div>
<a href="https://github.com/dparo/master-thesis.tex/releases/latest" target="_blank" rel="noopener noreferrer">
<img src="https://img.shields.io/badge/-View%20latest%20Release-063179?style=for-the-badge&logo=github" alt="View latest Release" />
</a>
</div>

## :construction: Manually compile the document

### :anchor: Requirements

- A GNU/Linux system
- A full distribution of LaTex (with latexmk)
- GNU make
- (Optional) Inkscape to automatically batch convert SVGs to PDFS
- (Optional) Ghostscript to optimize the PDF for release mode

### :inbox_tray: Cloning the repository

```sh
git clone --recursive https://github.com/dparo/master-thesis.tex
```

### :hammer: Building

```sh
make all
```

### :mag: Verify PDF/A-2b conformance

- Requires [veraPDF](https://verapdf.org/software/) to be installed and be available in `$PATH`.

```
make validate
```

If validation fails, veraPDF will output the failed rules.
You can take a look at all the available rules and their associated meaning [here](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFA-Part-1-rules).

## ℹ️ Additional resources

- [veraPDF free online validator for conformance to PDF/A-1 standard (WEB)](https://demo.verapdf.org): Prefer to use the native veraPDF executable if possible.
- [veraPDF free online validator for conformance to PDF/A-1 standard (Native)](https://verapdf.org/software/): Crossplatform, recommented over web version.
- [veraPDF list of validation rules with their meaning](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFA-Part-1-rules)
- [PDF to PDF/A online free converter](https://pdf.online/pdf-to-pdfa): Use this as a last resource if you fail to generate a proper PDF/A from Latex.
- [PDF online metadata viewer](https://www.metadata2go.com/): alternatively you can export the PDF metadata directly from the native veraPDF GUI.

### 📑 Documentation

- [Memoir documentclass documentation (PDF)](http://mirrors.ctan.org/macros/latex/contrib/memoir/memman.pdf).
- [PDFX Latex package documentation (PDF)](http://mirrors.ctan.org/macros/latex/contrib/pdfx/pdfx.pdf): The pdfx latex package is used to produce native PDF/A-1 conformant documents directly from Latex.
- [Biblatex Latex package documentation (PDF)](http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf).

## :sparkling_heart: Funding

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/J3J47WJB2)
