# LaTeX Template Guidelines

## Directory Structure

### LaTeX Source Files
- **All LaTeX source files must be placed in the `tex/` directory.**
- The main entry point is `tex/main.tex`, which imports other files using `\input{}`.
- The preamble with package imports is in `tex/preamble.tex`.
- Section files are stored in `tex/sections/`.
- Bibliography files are stored in `tex/bib/`.

### Figures and Images
- **All figures, images, and diagrams must be placed in the `figures/` directory.**
- Reference images in LaTeX using the path `../figures/image.png` (from tex directory).
- The graphicspath is already configured in the preamble.

### Build Output
- Build artifacts are generated in the `build/` directory.
- The final PDF will be in `build/pdf/` directory.

## LaTeX Compilation

### Using VS Code / Cursor
1. Open the repository in VS Code / Cursor.
2. Install the LaTeX Workshop extension if not already installed.
3. Open `tex/main.tex`.
4. Use the LaTeX Workshop build button or press `Ctrl+Alt+B` (`Cmd+Alt+B` on Mac).

### Using Command Line
```bash
# From the repository root
./scripts/compile.sh

# Or manually
cd tex
latexmk -r ../latexmkrc main.tex
```

### Cleaning Build Files
```bash
# From the repository root
cd tex
latexmk -C
```

## Adding New Content

### Adding a New Section
1. Create a new file in `tex/sections/`, e.g., `tex/sections/new_section.tex`.
2. Add the section content to this file.
3. Import the section in `tex/main.tex` using `\input{sections/new_section}`.

### Adding References
1. Add BibTeX entries to `tex/bib/refs.bib`.
2. Cite in the text using `\cite{reference_key}`.
3. Ensure the bibliography is included in `tex/main.tex` with:
   ```latex
   \printbibliography
   ```

### Adding Figures
1. Place figure files in the `figures/` directory.
2. Reference in LaTeX using:
   ```latex
   \begin{figure}[htbp]
     \centering
     \includegraphics[width=0.8\textwidth]{../figures/image.png}
     \caption{Description of the figure}
     \label{fig:label}
   \end{figure}
   ```

## GitHub Actions CI/CD

### Automated Builds
- Pushing to the `main` branch automatically triggers a LaTeX build via GitHub Actions.
- The workflow is defined in `.github/workflows/latex.yml`.
- The PDF is uploaded as an artifact and can be downloaded from the GitHub Actions page.

### Releases
- When pushing to the `main` branch, a new release is created with the PDF attached.
- The release is tagged with the run number.

## Configuration Files

### VS Code / Cursor Configuration
- `.vscode/settings.json` contains settings for the LaTeX Workshop extension.
- `.vscode/tasks.json` defines tasks for building, cleaning, and viewing LaTeX documents.

### latexmk Configuration
- `latexmkrc` contains custom settings for the latexmk build tool.
- It configures the LaTeX compiler, output directory, and cleanup options.

## Claude AI Assistant Configuration

### `.claude/claude.yml`
- Contains system prompts for Claude to understand the repository structure.
- Defines allowed tools and execution parameters.
- Helps Claude provide context-aware assistance for LaTeX documents.

### `.cursor/rules/latex_development.md`
- Contains development guidelines for working with this LaTeX template.
- Defines file organization rules and best practices.

## Best Practices

### Japanese Language Support
- Use LuaLaTeX with luatexja package for Japanese text (already included in preamble).
- Compile with lualatex for proper Japanese support.

### File Naming
- Use descriptive, lowercase names for section files.
- Separate words with underscores in filenames.
- Keep filenames concise but descriptive.

### Code Style
- Use consistent indentation in LaTeX files (2 or 4 spaces).
- Group related commands together.
- Add comments for complex sections or macros.
- Follow consistent capitalization in LaTeX commands.

### Version Control
- Commit frequently with descriptive messages.
- Include the PDF in .gitignore if you don't want to track it.
- Track changes to LaTeX source files, not generated files.
- Temporary files are automatically cleaned up after compilation.
