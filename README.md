# Model Template (AI/ML) module

This is a template repo for AI/ML model module.

## Features

- AI/ML model
- Python module/package
- Jupyter notebook
- Template
- CI/CD

---

## Installation

### 1. Prerequisites

- Install **Python (>= v3.9)**:
    - **[RECOMMENDED] Miniconda (v3)** - <https://docs.conda.io/en/latest/miniconda.html>
    - *[OPTIONAL] venv* - <https://docs.python.org/3/library/venv.html>
- *[OPTIONAL]* For **GPU (NVIDIA)**:
    - **NVIDIA GPU driver (>= v452.39)**
    - **NVIDIA CUDA (>= v11)** and **cuDNN (>= v8)**

For **development** environment:

- Install **git** - <https://git-scm.com/downloads>
- Setup an **SSH key** - <https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh>

### 2. Download or clone the repository

**2.1.** Prepare projects directory (if not exists):

```sh
# Create projects directory:
mkdir -pv ~/workspaces/projects

# Enter into projects directory:
cd ~/workspaces/projects

# Set repository owner:
export _REPO_OWNER=[REPO_OWNER]
# For example:
export _REPO_OWNER=username
```

**2.2.** Follow one of the below options **[A]** or **[B]**:

**A.** Download source code from releases page:

- Releases - <https://github.com/[REPO_OWNER]/model.python_template/releases>

```sh
# Set to downloaded version:
export _VERSION=[VERSION]
# For example:
export _VERSION=1.0.0

mv -v ~/Downloads/model.python_template-${_VERSION}.zip . && \
    unzip model.python_template-${_VERSION}.zip && \
    rm -v model.python_template-${_VERSION}.zip && \
    mv -v model.python_template-${_VERSION} model.python_template && \
    cd model.python_template
```

**B.** Or clone the repository (for development: git + ssh key):

```sh
git clone git@github.com:${_REPO_OWNER}/model.python_template.git && cd model.python_template
```

### 3. Install python dependencies

#### 3.1. Install base/common dependencies

```bash
< ./requirements.txt grep -v '^#' | xargs -t -L 1 pip install --timeout 60 --no-cache-dir
```

#### 3.2. Install hardware specific dependencies

Follow the one of below instructions based on your environment (A is recommended for most cases):

**A.** For Intel/AMD **x86_64** CPU:

```bash
< ./requirements.amd64.txt grep -v '^#' | xargs -t -L 1 pip install --timeout 60 --no-cache-dir
```

**B.** For **arm64/aarch64** CPU:

```bash
< ./requirements.arm64.txt grep -v '^#' | xargs -t -L 1 pip install --timeout 60 --no-cache-dir
```

**C.** For **NVIDIA GPU** and **x86_64** CPU:

```bash
< ./requirements.gpu.txt grep -v '^#' | xargs -t -L 1 pip install --timeout 60 --no-cache-dir
```

### 4. Install the module

Follow the one of below instructions based on your situation (A and B recommended for most cases):

**A.** Copy the **module** into the project directory [Recommended]:

```bash
# Copy the module source code to the project:
cp -r model_template [PROJECT_DIR]
# For example:
cp -r model_template /some/path/project/
```

**B.** Add module path to **PYTHONPATH**:

```bash
# Add current path to PYTHONPATH:
export PYTHONPATH="${PWD}:${PYTHONPATH}"

# Or add the module path to PYTHONPATH:
export PYTHONPATH="[MODULE_PATH]:${PYTHONPATH}"
# For example:
export PYTHONPATH="/some/path/model_template:${PYTHONPATH}"
```

**C.** Install **wheel package** (Not recommended):

Note: Not completed yet, because the GPU, CPU and ARM compatible wheel packages are not separated yet.

```bash
# Not implemented yet.

# Build wheel package:
pip install --upgrade pip setuptools wheel
python setup.py bdist_wheel

# Install wheel package:
pip install ./dist/model_template-[VERSION]-py3-none-any.whl
# For example:
pip install ./dist/model_template-0.0.1-py3-none-any.whl
```

## Usage/Examples

### Simple example

```python
from model_template import ModelTemplate
```

### Advanced example

```python
# Not implemented yet
```

:thumbsup: :sparkles:

---

## Configuration

```yml
```

### Environment variables

You can use the following environment variables to configure:

[**`.env.example`**](.env.example)

```sh
```

### Arguments

You can use the following arguments to configure:

```txt
```

## Running Tests

To run tests, run the following command:

```sh
# Install test dependencies:
pip install --upgrade pytest

# Run tests:
pytest
```

## Documentation

...

## Roadmap

...

---

## References

- <https://packaging.python.org/en/latest/tutorials/packaging-projects>
- <https://python-packaging.readthedocs.io/en/latest>
