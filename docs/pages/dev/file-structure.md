# File Structure

```txt
project/
├── .github/                # GitHub specific files
|   ├── workflows/              # GitHub actions as workflows
|   └── release.yml             # Categories and labels for release notes
├── .vscode/                # VSCode specific files
|   ├── extensions.json         # Recommended extensions for the workspace
|   └── settings.json           # Common VSCode settings for the workspace (e.g. formatting, linting, etc...)
├── data/                   # Data used for this project (SHOULD NOT BE INCLUDED IN THE REPOSITORY)
|   ├── external/               # Data from third party sources
|   ├── processed/              # The final datasets for modeling
|   └── raw/                    # The original raw data
├── docs/                   # Documentation of this project
|   ├── assets/                 # Any assets (images, audios, videos, js, css, html, etc...) used for the documentation
|   ├── diagrams/               # Diagrams related to this project
|   ├── pages/                  # MkDocs pages - markdown files
|   ├── references/             # References related to this project (papers, articles, manuals, etc...)
|   └── reports/                # Reports based on results of this project
├── examples/               # Example source codes of this project
├── models/                 # Directory for storing multiple models (SHOULD NOT BE INCLUDED IN THE REPOSITORY)
|   ├── model.v1/               # AI/ML model files, weights, artifacts, checkpoints, metadata, and configs
|   ├── model.v2/
|   └── .../
├── notebooks/              # Jupyter notebooks for exploratory data analysis, data preprocessing, model training, etc...
├── requirements/           # Python dependency requirements for different environments
├── results/                # Results of this model (SHOULD NOT BE INCLUDED IN THE REPOSITORY)
├── scripts/                # Helpful scripts to automate tasks or assist in the development process
├── simple_model/           # Main CODEBASE of this project as a python module
|   ├── modules/                # External modules for this project
|   |   ├── module_1/
|   |   ├── module_2/
|   |   └── .../
|   ├── __init__.py             # Initialize the module to be used as a package
|   ├── __version__.py          # Version of the module (should be updated and used with each release)
|   └── ...                     # Other main python files of this module
├── templates/              # Template files (if any, e.g. config files, etc...) used in this project
├── tests/                  # Tests for this project
|   ├── __init__.py             # Initialize the test module
|   ├── conftest.py             # Presets for pytest (e.g. fixtures, plugins, pre/post test hooks, etc...)
|   ├── test_1.py               # Test case files
|   ├── test_2.py
|   └── ...
├── __init__.py             # Initialize the whole project as a python module to import from other modules
├── .editorconfig           # Editor configuration for consistent coding styles for different editors
├── .env.example            # Example environment variables file
├── .gitignore              # Files and directories to be ignored by git (e.g. data, models, results, etc...)
├── .markdownlint.json      # Markdown linting rules
├── CHANGELOG.md            # List of changes for each version of the project
├── environment.yml         # Conda environment file
├── LICENSE.txt             # License file for this project
├── Makefile                # Makefile for common commands and automation
├── MANIFEST.in             # Manifest file for setuptools (to include/exclude files in the source distribution)
├── mkdocs.yml              # MkDocs configuration file
├── pyproject.toml          # PEP 518 configuration file for python packaging
├── pytest.ini              # Pytest configuration file
├── README.md               # Main README file for this project
├── requirements.txt        # Main python dependency requirements for this project
├── setup.cfg               # Configuration for setuptools
└── setup.py                # Setup script for setuptools (for backward compatibility)
```
