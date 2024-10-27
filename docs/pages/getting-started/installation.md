# Installation

## 1. Download or clone the repository

**1.1.** Prepare projects directory (if not exists):

```sh
# Create projects directory:
mkdir -pv ~/workspaces/projects

# Enter into projects directory:
cd ~/workspaces/projects
```

**1.2.** Follow one of the below options **[A]** or **[B]**:

**A.** Clone the repository:

```sh
git clone git@github.com:bybatkhuu/model.python-template.git simple_model && \
    cd simple_model
```

**B.** Download source code (for **offline** environment):

1. Download archived **zip** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Extract it into the project directory.
3. Rename the extracted directory from **`model.python-template`** to **`simple_model`**.

### 3. Install the module

> [!NOTE]
> Choose one of the following methods to install the module **[A ~ F]**:

**A.** Install with **pip**:

```sh
# Install directly from source:
pip install .
# Or install with **editable** mode (for **DEVELOPMENT**):
pip install -e .
```

**B.** Install from git repository (only works on **public** repo):

```sh
# Install directly from GitHub:
pip install git+https://github.com/bybatkhuu/model.python-template.git
```

**C.** Install from **pre-built package** files (for **PRODUCTION**):

1. Download **`.whl`** or **`.tar.gz`** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Install with pip:

```sh
# Install from .whl file:
pip install ./simple_model-[VERSION]-py3-none-any.whl
# Or install from .tar.gz file:
pip install ./simple_model-[VERSION].tar.gz
```

**D.** Build the **package** and install with **pip**:

```sh
# Install python build tool:
pip install -U pip build

# Build python package:
python -m build

# Install from .whl file:
pip install ./dist/simple_model-[VERSION]-py3-none-any.whl
# Or install from .tar.gz file:
pip install ./dist/simple_model-[VERSION].tar.gz
```

**E.** Copy the **module** into the project directory (for **testing**):

```sh
# Install python dependencies:
pip install -r ./requirements.txt

# Copy the module source code into the project:
cp -r ./src/simple_model [PROJECT_DIR]
# For example:
cp -r ./src/simple_model /some/path/project/
```

**F.** Manually add module path into **PYTHONPATH** (not recommended):

```sh
# Add current path to PYTHONPATH:
export PYTHONPATH="${PWD}/src:${PYTHONPATH}"

# Or add the module path to PYTHONPATH:
export PYTHONPATH="[MODULE_PATH]:${PYTHONPATH}"
# For example:
export PYTHONPATH="/some/path/model.python-template/src:${PYTHONPATH}"
```
