# Python Development Rules

## Environment Setup

### Conda Environment
- 解析スクリプトを実行する前に、必ず`py-ten`仮想環境をアクティベートすること
- Always activate the `py-ten` conda environment before running analysis scripts:
  ```bash
  conda activate py-ten
  ```

## File Creation and Output Rules

### Default Working Directory
- 特別な指示がない限り、`.py`ファイルの作成や作成ファイルの出力結果の保存は、`workbench`フォルダ内で行う
- Unless specifically instructed otherwise, create `.py` files and save output results within the `workbench` folder

### File Organization
- Keep experimental and temporary Python scripts in the `workbench` directory
- Only move files to other directories when explicitly requested or when they are part of the main analysis pipeline
- Maintain clean separation between production analysis scripts (in `analysis_steps`) and experimental/temporary work (in `workbench`)

### Path References
- When creating files in `workbench`, use relative paths from the project root
- Ensure proper path handling for data access from the `workbench` directory to other project directories

### Examples
- ✅ Create test scripts in: `workbench/test_script.py`
- ✅ Save experimental outputs to: `workbench/output_data.csv`
- ❌ Don't create temporary files in: `analysis_steps/` (unless part of the main pipeline)
- ❌ Don't create temporary files in: `data/` (unless they are processed data outputs) 