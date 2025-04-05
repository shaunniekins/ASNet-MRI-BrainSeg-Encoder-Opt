# Optimizing AS-Net for MRI Brain Tumor Segmentation: A Comparative Study of Different Encoders for Improved Segmentation Performance

This repository contains the LaTeX source files for a thesis focused on optimizing the Attention Synergy Network (AS-Net) for segmenting brain tumors in MRI images. The research compares the performance of the original VGG16 encoder with lightweight alternatives (MobileNetV3, EfficientNetV2) to improve segmentation accuracy and computational efficiency.

## DIRECTORY STRUCTURE

### Main Files

- `thesis.tex`: This is the main file that compiles the entire document. It imports all other parts.
- `gatechthesis.cls`: This is the class file that defines the document format and layout.

### Front Matter Files (Document Setup)

- `declaration.tex`: Contains the thesis approval and certification text.
- `acknowledgments.tex`: Where you write your acknowledgments.
- `summary.tex`: Contains the abstract of your thesis.
- `abbrevs.tex`: Defines acronyms and abbreviations used in your document.
- `approvalPage.tex`: Contains the approval page format.

### Content Files

- `chapters/chapter1.tex`: Introduction and Background chapter.
- `chapters/chapter2.tex`: Methodology chapter.
- `chapters/chapter3.tex`: Results chapter.
- `chapters/chapter4.tex`: Discussion chapter.
- `chapters/chapter5.tex`: Conclusion chapter.
- `chapters/appendix.tex`: Appendices to your thesis.

### Reference Management

- `references.bib`: Bibliography entries in BibTeX format.

## HOW TO USE THIS TEMPLATE

1. Edit `thesis.tex` to update your title, name, and other basic information.
2. Modify the content in the chapter files under the `chapters/` directory.
3. Update your references in `references.bib`.
4. Update your acknowledgments, summary, and declaration files.
5. Compile the document using a LaTeX compiler.

## COMPILATION SEQUENCE

To compile the document:

1. Run pdflatex on thesis.tex
2. Run biber on thesis
3. Run pdflatex again (twice) on thesis.tex

Most LaTeX editors like TeXstudio, Overleaf, or VS Code with LaTeX Workshop extension can handle this automatically.

## RECOMMENDED ORGANIZATION

For better organization, you might want to:

1. Keep all images in a `figures/` directory
2. Maintain one chapter per file
3. Split long chapters into multiple files if needed

## REFERENCE GUIDE

- To add a citation: \cite{citation_key}
- To reference a figure: \ref{fig:label_name}
- To reference a table: \ref{tbl:label_name}
- To reference a section: \ref{sec:label_name}

## TYPICAL WORKFLOW

1. Write your content in the chapter files
2. Add figures and tables as needed
3. Add citations from the references.bib file
4. Compile and review the PDF output
5. Make adjustments and repeat until finished

For LaTeX help, refer to resources like:

- <https://www.latex-project.org/>
- <https://www.overleaf.com/learn>
