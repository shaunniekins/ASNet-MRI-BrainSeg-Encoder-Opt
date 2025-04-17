# Optimizing AS-Net for MRI Brain Tumor Segmentation: A Comparative Study of Different Encoders for Improved Segmentation Performance

This repository contains the LaTeX source files for a thesis focused on optimizing the Attention Synergy Network (AS-Net) for segmenting brain tumors in MRI images. The research compares the performance of the original VGG16 encoder with lightweight alternatives (MobileNetV3, EfficientNetV2) to improve segmentation accuracy and computational efficiency, evaluated on the BraTS 2023-GLI (Task 1) dataset.

## DIRECTORY STRUCTURE

### Main Files

- `thesis.tex`: This is the main file that compiles the entire document. It imports all other parts.
- `gatechthesis.cls`: This is the class file that defines the document format and layout.

### Front Matter Files (Document Setup)

- `sections/approvalPage.tex`: Contains the approval page format.
- `sections/dedication.tex`: Contains the dedication.
- `sections/acknowledgment.tex`: Where you write your acknowledgments.
- `sections/abstract.tex`: Contains the abstract of your thesis.
- `sections/abbrevs.tex`: Defines acronyms and abbreviations used in your document.

### Content Files

- `chapters/chapter1.tex`: Introduction and Background chapter.
- `chapters/chapter2.tex`: Review of Related Literature chapter.
- `chapters/chapter3.tex`: Methodology chapter.
- `chapters/chapter4.tex`: Results and Discussion chapter.
- `chapters/chapter5.tex`: Summary, Conclusion and Recommendation chapter.
- `sections/appendix.tex`: Appendices to your thesis.
- `sections/bionote.tex`: Contains the author bionotes.

### Reference Management

- `references.bib`: Bibliography entries in BibTeX format.

## HOW TO USE THIS TEMPLATE

1. Edit `thesis.tex` to update your title, name, and other basic information.
2. Modify the content in the chapter files under the `chapters/` directory and section files under `sections/`.
3. Update your references in `references.bib`.
4. Update your acknowledgments, abstract, dedication, and bionote files.
5. Compile the document using a LaTeX compiler (XeLaTeX or LuaLaTeX recommended due to fontspec).

## COMPILATION SEQUENCE

To compile the document (especially with `biblatex` and `glossaries`):

1. Run `xelatex` (or `lualatex`) on `thesis.tex`
2. Run `biber` on `thesis`
3. Run `makeglossaries thesis` (if using acronyms list)
4. Run `xelatex` (or `lualatex`) again (twice) on `thesis.tex`

Most LaTeX editors like TeXstudio, Overleaf, or VS Code with LaTeX Workshop extension can handle this automatically or be configured to do so.

## RECOMMENDED ORGANIZATION

For better organization, you might want to:

1. Keep all images in a `figures/` directory (and potentially subdirectories).
2. Maintain one chapter per file in the `chapters/` directory.
3. Keep front/back matter sections in the `sections/` directory.
4. Place custom images (like profile pictures) in an `images/` directory.

## REFERENCE GUIDE

- To add a citation: `\parencite{citation_key}` (for parenthetical) or `\textcite{citation_key}` (for in-text).
- To reference a figure: `\ref{fig:label_name}`
- To reference a table: `\ref{tab:label_name}`
- To reference a section: `\ref{sec:label_name}`
- To use an acronym: `\gls{acronym_key}` (first use) or `\gls{acronym_key}` (subsequent uses). Ensure `\makeglossaries` is in the preamble and `\printglossary` or `\makeListOfAcronyms` is used.

## TYPICAL WORKFLOW

1. Write your content in the chapter and section files.
2. Add figures and tables as needed, placing image files in `figures/`.
3. Add citations from the `references.bib` file using `\parencite` or `\textcite`.
4. Define and use acronyms via the `glossaries` package and `sections/abbrevs.tex`.
5. Compile and review the PDF output.
6. Make adjustments and repeat until finished.

For LaTeX help, refer to resources like:

- <https://www.latex-project.org/>
- <https://www.overleaf.com/learn>
- `biblatex` package documentation
- `glossaries` package documentation
