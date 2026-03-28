from __future__ import annotations

import os
import shutil
import stat
import subprocess
import textwrap
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]


def write_file(path: Path, content: str, executable: bool = False) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(textwrap.dedent(content).lstrip(), encoding="utf-8")
    if executable:
        path.chmod(path.stat().st_mode | stat.S_IXUSR)


def copy_script(relative_path: str, destination_root: Path) -> Path:
    source = REPO_ROOT / relative_path
    destination = destination_root / relative_path
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)
    return destination


def run_script(
    repo_root: Path,
    command: list[str],
    *,
    env: dict[str, str] | None = None,
) -> subprocess.CompletedProcess[str]:
    full_env = os.environ.copy()
    if env:
        full_env.update(env)
    return subprocess.run(
        command,
        cwd=repo_root,
        capture_output=True,
        text=True,
        env=full_env,
        check=False,
    )


def test_check_env_accepts_current_cursor_rule_layout(tmp_path: Path) -> None:
    repo = tmp_path / "repo"
    copy_script("utility/check_env.py", repo)

    required_dirs = [
        "tex/sections",
        "tex/bib",
        "figures",
        "build/pdf",
        ".claude/commands",
        ".cursor/rules",
        ".github/workflows",
        ".codex",
        "utility",
        "sharing",
        "plan",
        "results",
        "workbench",
    ]
    for relative_dir in required_dirs:
        (repo / relative_dir).mkdir(parents=True, exist_ok=True)

    required_files = {
        "tex/main.tex": "% main\n",
        "tex/preamble.tex": "% preamble\n",
        "tex/bib/refs.bib": "",
        "scripts/compile.sh": "#!/usr/bin/env bash\n",
        "latexmkrc": "",
        ".claude/claude.yml": "",
        ".claude/commands/gemini-search.md": "",
        ".codex/config.toml": "",
        ".cursor/rules/00-core-workflow.mdc": "",
        "AGENTS.md": "",
        "CLAUDE.md": "",
        "GEMINI.md": "",
        "environment.yml": "",
        "sharing/ai-driven-coding.py": "",
        "sharing/ai-driven-coding.md": "",
    }
    for relative_path, content in required_files.items():
        write_file(repo / relative_path, content, executable=relative_path.endswith(".sh"))

    fake_bin = repo / "fake-bin"
    write_file(fake_bin / "latexmk", "#!/usr/bin/env bash\nexit 0\n", executable=True)
    write_file(fake_bin / "lualatex", "#!/usr/bin/env bash\nexit 0\n", executable=True)

    result = run_script(
        repo,
        ["python", "utility/check_env.py"],
        env={"PATH": f"{fake_bin}:{os.environ['PATH']}"},
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Cursor rule files found" in result.stdout
    assert "finished successfully" in result.stdout


def test_compile_clean_temp_removes_intermediate_files(tmp_path: Path) -> None:
    repo = tmp_path / "repo"
    copy_script("scripts/02_compile.sh", repo)

    write_file(repo / "tex/example.tex", "% example\n")
    (repo / "build").mkdir(parents=True, exist_ok=True)

    fake_bin = repo / "fake-texlive-bin"
    write_file(
        fake_bin / "latexmk",
        """
        #!/usr/bin/env bash
        set -e
        tex_file="${@: -1}"
        base="${tex_file%.tex}"
        mkdir -p "temp/cache"
        printf 'pdf' > "temp/${base}.pdf"
        printf 'bbl' > "temp/${base}.bbl"
        touch "temp/${base}.aux" "temp/${base}.blg" "temp/${base}.log" \
              "temp/${base}.out" "temp/${base}.toc"
        printf 'cache' > "temp/cache/state.txt"
        """,
        executable=True,
    )
    write_file(
        fake_bin / "pdfinfo",
        """
        #!/usr/bin/env bash
        echo "Pages: 1"
        """,
        executable=True,
    )

    result = run_script(
        repo,
        ["bash", "scripts/02_compile.sh", "example", "--clean-temp"],
        env={"TEXLIVE_PATH": str(fake_bin)},
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert (repo / "build/pdf/example.pdf").exists()
    assert (repo / "tex/bib/example.bbl").exists()
    assert list((repo / "tex/temp").iterdir()) == []
    assert "中間ファイルはクリーンアップ済みです" in result.stdout


def test_tex2docx_handles_missing_aux_without_unbound_variable(tmp_path: Path) -> None:
    repo = tmp_path / "repo"
    copy_script("scripts/03_tex2docx.sh", repo)

    write_file(repo / "tex/bad.tex", "\\documentclass{article}\n\\begin{document}x\\end{document}\n")

    fake_bin = repo / "fake-bin"
    write_file(
        fake_bin / "lualatex",
        """
        #!/usr/bin/env bash
        exit 1
        """,
        executable=True,
    )
    write_file(fake_bin / "bibtex", "#!/usr/bin/env bash\nexit 0\n", executable=True)
    write_file(
        fake_bin / "pandoc",
        """
        #!/usr/bin/env bash
        set -e
        output=""
        for arg in "$@"; do
          case "$arg" in
            --output=*)
              output="${arg#--output=}"
              ;;
          esac
        done
        printf 'docx' > "$output"
        """,
        executable=True,
    )

    result = run_script(
        repo,
        ["bash", "scripts/03_tex2docx.sh", "tex/bad.tex"],
        env={"PATH": f"{fake_bin}:{os.environ['PATH']}"},
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert (repo / "build/docx/bad.docx").exists()
    assert "unbound variable" not in (result.stdout + result.stderr)


def test_extract_tables_outputs_numeric_cells_without_excel_prefix(tmp_path: Path) -> None:
    repo = tmp_path / "repo"
    copy_script("scripts/04_extract_tables.sh", repo)

    write_file(
        repo / "tex/table_test.tex",
        r"""
        \documentclass{article}
        \usepackage{booktabs}
        \begin{document}
        \begin{table}
        \centering
        \begin{tabular}{ll}
        \toprule
        Name & Value \\
        \midrule
        Alpha & 1.23 \\
        Beta & 4.56 \\
        \bottomrule
        \end{tabular}
        \end{table}
        \end{document}
        """,
    )

    result = run_script(repo, ["bash", "scripts/04_extract_tables.sh", "tex/table_test.tex"])

    assert result.returncode == 0, result.stdout + result.stderr
    csv_path = repo / "build/csv/table_test_table_01.csv"
    assert csv_path.exists()
    csv_text = csv_path.read_text(encoding="utf-8")
    assert "Alpha,1.23" in csv_text
    assert "Beta,4.56" in csv_text
    assert "'1.23" not in csv_text
    assert "TeXディレクトリが見つかりません" not in (result.stdout + result.stderr)
