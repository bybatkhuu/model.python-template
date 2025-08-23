---
title: Configuration
---

# ⚙️ Configuration

[**`templates/configs/config.yml`**](https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}/blob/main/templates/configs/config.yml):

```yaml
{{cookiecutter.module_name}}:                       # Just an example to group the configs (Not necessary)
  models_dir: "models"                              # Directory where the models are saved
  model_name: "linear_regression.v0.0.1-250101"     # Name of the model as sub-directory
  threshold: 0.5                                    # Threshold for similarity check
```

## 🌎 Environment Variables

[**`.env.example`**](https://github.com/{{cookiecutter.repo_owner}}/{{cookiecutter.repo_name}}/blob/main/.env.example):

```sh
# ENV=LOCAL
# DEBUG=false
# TZ=UTC
# PYTHONDONTWRITEBYTECODE=0
```
