# 🛠 Installation

## 1. 📥 Download or clone the repository

> [!TIP]
> Skip this step, if you're going to install the module directly from **git** repository.

**1.1.** Prepare projects directory (if not exists):

```sh
# Create projects directory:
mkdir -pv ~/workspaces/projects

# Enter into projects directory:
cd ~/workspaces/projects
```

**1.2.** Follow one of the below options **[A]**, **[B]** or **[C]**:

**OPTION A.** Clone the repository:

```sh
git clone https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}.git && \
    cd {{cookiecutter.repo_name}}
```

**OPTION B.** Clone the repository (for **DEVELOPMENT**: git + ssh key):

```sh
git clone git@github.com:{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}.git && \
    cd {{cookiecutter.repo_name}}
```

**OPTION C.** Download source code:

1. Download archived **zip** file from [**releases**](https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}/releases).
2. Extract it into the projects directory.

## 2. 📦 Install the module

> [!NOTE]
> Choose one of the following methods to install the module **[A ~ E]**:

**OPTION A.** Install directly from **git** repository:

```sh
pip install git+https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}.git
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

1. Download **`.whl`** or **`.tar.gz`** file from [**releases**](https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}/releases).
2. Install with pip:

```sh
# Install from .whl file:
pip install ./{{cookiecutter.module_name}}-[VERSION]-py3-none-any.whl
# Or install from .tar.gz file:
pip install ./{{cookiecutter.module_name}}-[VERSION].tar.gz
```

**OPTION E.** Copy the **module** into the project directory (for **testing**):

```sh
# Install python dependencies:
pip install -r ./requirements.txt

# Copy the module source code into the project:
cp -r ./src/{{cookiecutter.module_name}} [PROJECT_DIR]
# For example:
cp -r ./src/{{cookiecutter.module_name}} /some/path/project/
```
