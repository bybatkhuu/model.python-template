# ⚙️ Configuration

**`templates/configs/config.yml`**:

```yaml
{{cookiecutter.module_name}}:                                       # Just an example to group the configs (Not necessary)
  models_dir: "models"                              # Directory where the models are saved
  model_name: "linear_regression.v0.0.1-240101"     # Name of the model as sub-directory
  threshold: 0.5                                    # Threshold for similarity check
```

## 🌎 Environment Variables

**`.env.example`**:

```sh
# ENV=development
# DEBUG=true
```
