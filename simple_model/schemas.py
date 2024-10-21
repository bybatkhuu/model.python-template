# -*- coding: utf-8 -*-

import pydantic
from pydantic import BaseModel, constr, Field

if "2.0.0" <= pydantic.__version__:
    from pydantic import ConfigDict


class ExtraBaseModel(BaseModel):
    if "2.0.0" <= pydantic.__version__:
        model_config = ConfigDict(extra="allow")
    else:

        class Config:
            extra = "allow"


class ModelConfigPM(ExtraBaseModel):
    models_dir: constr(strip_whitespace=True) = Field(  # type: ignore
        default="models", min_length=2, max_length=1023
    )
    modelName: constr(strip_whitespace=True) = Field(  # type: ignore
        default="linear_regression.v0.0.1-240101",
        min_length=2,
        max_length=127,
        alias="model_name",
    )
    threshold: float = Field(default=0.5, ge=0.0, le=1.0)


__all__ = ["ModelConfigPM"]
