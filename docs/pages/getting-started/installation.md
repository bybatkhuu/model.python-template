# 🛠 Installation

## 1. 📥 Download or clone the repository

**1.1.** Prepare projects directory (if not exists):

```sh
# Create projects directory:
mkdir -pv ~/workspaces/projects

# Enter into projects directory:
cd ~/workspaces/projects
```

**1.2.** Follow one of the below options **[A]** or **[B]**:

**OPTION A.** Clone the repository:

```sh
git clone git@github.com:bybatkhuu/model.python-template.git simple_model && \
    cd simple_model
```

**OPTION B.** Download source code:

1. Download archived **zip** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Extract it into the project directory.
3. Rename the extracted directory from **`model.python-template`** to **`simple_model`**.

## 2. 📦 Install the module

> [!NOTE]
> Choose one of the following methods to install the module **[A ~ E]**:

**OPTION A.** Install directly from **git** repository:

```sh
pip install git+https://github.com/bybatkhuu/model.python-template.git
```

**OPTION B.** Install from the downloaded **source code**:

```sh
# Install directly from the source code:
pip install .
# Or install with editable mode:
pip install -e .
```

**OPTION C.** Install for **DEVELOPMENT** environment:

```sh
pip install -r ./requirements/requirements.dev.txt
```

**OPTION D.** Install from **pre-built package** files (for **PRODUCTION**):

1. Download **`.whl`** or **`.tar.gz`** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Install with pip:

```sh
# Install from .whl file:
pip install ./simple_model-[VERSION]-py3-none-any.whl
# Or install from .tar.gz file:
pip install ./simple_model-[VERSION].tar.gz
```

**OPTION E.** Copy the **module** into the project directory (for **testing**):

```sh
# Install python dependencies:
pip install -r ./requirements.txt

# Copy the module source code into the project:
cp -r ./src/simple_model [PROJECT_DIR]
# For example:
cp -r ./src/simple_model /some/path/project/
```
