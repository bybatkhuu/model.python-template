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
    """Pydantic model for SimpleModel config.

    Attributes:
        models_dir (str  ): Directory where models are stored. Defaults to "models".
        modelName  (str  ): Name of the model which is also the sub-directory name. Defaults to "linear_regression.v0.0.1-240101".
        threshold  (float): Threshold value for the similarity score. Defaults to None.
    """

    models_dir: constr(strip_whitespace=True) = Field(  # type: ignore
        default="./models", min_length=2, max_length=1023
    )
    modelName: constr(strip_whitespace=True) = Field(  # type: ignore
        default="linear_regression.v0.0.1-240101",
        min_length=2,
        max_length=127,
        alias="model_name",
    )
    threshold: float = Field(default=0.5, ge=0.0, le=1.0)


__all__ = ["ModelConfigPM"]
