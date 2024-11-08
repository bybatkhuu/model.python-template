# Model Template (AI/ML) module

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bybatkhuu/model.python-template/2.build-publish.yml?logo=GitHub)](https://github.com/bybatkhuu/model.python-template/actions/workflows/2.build-publish.yml)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/bybatkhuu/model.python-template?logo=GitHub)](https://github.com/bybatkhuu/model.python-template/releases)

This is a template repo for AI/ML model module.

## Features

- AI/ML model
- Python module/package
- Jupyter notebook
- Research
- Project Structure
- Template
- CI/CD

---

## Installation

### 1. Prerequisites

- Install **Python (>= v3.9)** and **pip (>= 23)**:
    - **[RECOMMENDED] [Miniconda (v3)](https://docs.anaconda.com/miniconda)**
    - *[arm64/aarch64] [Miniforge (v3)](https://github.com/conda-forge/miniforge)*
    - *[Python virutal environment] [venv](https://docs.python.org/3/library/venv.html)*
- *[OPTIONAL]* For **GPU (NVIDIA)**:
    - **NVIDIA GPU driver (>= v452.39)**
    - **NVIDIA CUDA (>= v11)** and **cuDNN (>= v8)**

For **DEVELOPMENT** environment:

- Install [**git**](https://git-scm.com/downloads)
- Setup an [**SSH key**](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) ([video tutorial](https://www.youtube.com/watch?v=snCP3c7wXw0))

### 2. Download or clone the repository

**2.1.** Prepare projects directory (if not exists):

```sh
# Create projects directory:
mkdir -pv ~/workspaces/projects

# Enter into projects directory:
cd ~/workspaces/projects
```

**2.2.** Follow one of the below options **[A]** or **[B]**:

**A.** Clone the repository:

```sh
git clone git@github.com:bybatkhuu/model.python-template.git simple_model && \
    cd simple_model
```

**B.** Download source code:

1. Download archived **zip** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Extract it into the project directory.
3. Rename the extracted directory from **`model.python-template`** to **`simple_model`**.

### 3. Install the module

> [!NOTE]
> Choose one of the following methods to install the module **[A ~ E]**:

**A.** Install directly from **git** repository:

```sh
pip install git+https://github.com/bybatkhuu/model.python-template.git
```

**B.** Install from the downloaded **source code**:

```sh
# Install directly from the source code:
pip install .
# Or install with editable mode:
pip install -e .
```

**C.** Install for **DEVELOPMENT** environment:

```sh
pip install -r ./requirements/requirements.dev.txt
```

**D.** Install from **pre-built package** files (for **PRODUCTION**):

1. Download **`.whl`** or **`.tar.gz`** file from [**releases**](https://github.com/bybatkhuu/model.python-template/releases).
2. Install with pip:

```sh
# Install from .whl file:
pip install ./simple_model-[VERSION]-py3-none-any.whl
# Or install from .tar.gz file:
pip install ./simple_model-[VERSION].tar.gz
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

## Usage/Examples

### Simple

[**`examples/simple/main.py`**](https://github.com/bybatkhuu/model.python-template/blob/main/examples/simple/main.py):

```python
## Standard libraries
import sys
import logging
from typing import Any

## Third-party libraries
import numpy as np
from numpy.typing import NDArray

## Internal modules
from simple_model import SimpleModel


logger = logging.getLogger(__name__)


if __name__ == "__main__":
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)

    # Pre-defined variables (for customizing and testing)
    _model_dir = "./models"
    _model_name = "linear_regression.v0.0.1-24"

    _X_train = np.array([[1], [2], [3], [4], [5]])
    _y_train = np.array([2, 4, 6, 8, 10])

    _X_test = np.array([[6], [7], [8]])
    _y_test = np.array([10, 14, 16])

    # Create the model instance
    _config = {"models_dir": _model_dir, "model_name": _model_name}
    _model = SimpleModel(config=_config)

    # Train or load the model
    if not SimpleModel.is_model_files_exist(**_config):
        _model.train(X=_X_train, y=_y_train)
    else:
        _model.load()

    # Predict the target values
    _y_pred: NDArray[Any] = _model.predict(X=_X_test)
    logger.info(f"Predicted values for {_X_test.flatten()}: {_y_pred.flatten()}")

    # Evaluate the model
    _r2_score: float = _model.score(y_true=_y_test, y_pred=_y_pred)
    logger.info(f"R^2 score: {_r2_score}")

    _is_similar: bool = _model.is_similar(X=_X_test, y=_y_test)
    logger.info(f"Is similar: {_is_similar}")

    # Save the model
    if _model.is_trained() and (not SimpleModel.is_model_files_exist(**_config)):
        _model.save()

    logger.info("Done!")
```

:thumbsup: :sparkles:

---

## Configuration

[**`templates/configs/config.yml`**](https://github.com/bybatkhuu/model.python-template/blob/main/templates/configs/config.yml):

```yaml
simple_model:                                       # Just an example to group the configs (Not necessary)
  models_dir: "./models"                            # Directory where the models are saved
  model_name: "linear_regression.v0.0.1-240101"     # Name of the model as sub-directory
  threshold: 0.5                                    # Threshold for similarity check
```

### Environment Variables

[**`.env.example`**](https://github.com/bybatkhuu/model.python-template/blob/main/.env.example):

```sh
# ENV=development
# DEBUG=true
```

## Running Tests

To run tests, run the following command:

```sh
# Install python test dependencies:
pip install -r ./requirements/requirements.test.txt

# Run tests:
python -m pytest -sv -o log_cli=true
# Or use the test script:
./scripts/test.sh -l -v -c
```

## Build Package

To build the python package, run the following command:

```sh
# Install python build dependencies:
pip install -r ./requirements/requirements.build.txt

# Build python package:
python -m build
# Or use the build script:
./scripts/build.sh
```

## Generate Docs

To build the documentation, run the following command:

```sh
# Install python documentation dependencies:
pip install -r ./requirements/requirements.docs.txt

# Serve documentation locally (for development):
mkdocs serve
# Or use the docs script:
./scripts/docs.sh

# Or build documentation:
mkdocs build
# Or use the docs script:
./scripts/docs.sh -b
```

## Documentation

- [Docs](https://github.com/bybatkhuu/model.python-template/blob/main/docs)
- [Home](https://github.com/bybatkhuu/model.python-template/blob/main/docs/README.md)

### Getting Started

- [Prerequisites](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/getting-started/prerequisites.md)
- [Installation](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/getting-started/installation.md)
- [Configuration](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/getting-started/configuration.md)
- [Examples](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/getting-started/examples.md)
- [Error Codes](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/getting-started/error-codes.md)

### [API Documentation](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/api-docs/README.md)

### Development

- [Test](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/test.md)
- [Build](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/build.md)
- [Docs](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/docs.md)
- [CI/CD](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/cicd.md)
- [Scripts](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/scripts/README.md)
- [File Structure](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/file-structure.md)
- [Sitemap](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/sitemap.md)
- [Contributing](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/contributing.md)
- [Roadmap](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/dev/roadmap.md)

### Research

- [Reports](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/research/reports.md)
- [Benchmarks](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/research/benchmarks.md)
- [References](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/research/references.md)

### [Release Notes](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/release-notes.md)

### [Blog](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/blog/README.md)

### About

- [FAQ](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/about/faq.md)
- [Authors](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/about/authors.md)
- [Contact](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/about/contact.md)
- [License](https://github.com/bybatkhuu/model.python-template/blob/main/docs/pages/about/license.md)

---

## References

- <https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html>
- <https://packaging.python.org/en/latest/tutorials/packaging-projects>
- <https://python-packaging.readthedocs.io/en/latest>
