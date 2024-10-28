# -*- coding: utf-8 -*-

import logging
from typing import Generator, Any, Union

import pytest
import numpy as np
from numpy.typing import NDArray
from pydantic import BaseModel, ValidationError
from sklearn.linear_model import LinearRegression

try:
    from simple_model import SimpleModel, ModelConfigPM
except ImportError:
    from src.simple_model import SimpleModel, ModelConfigPM


logger = logging.getLogger(__name__)


@pytest.fixture
def model() -> Generator[SimpleModel, None, None]:
    _model = SimpleModel()
    yield _model
    del _model


def test_init(model: SimpleModel) -> None:
    logger.info("Testing initialization of 'SimpleModel'...")

    assert model is not None
    assert isinstance(model, SimpleModel)
    assert isinstance(model.model, LinearRegression)
    assert isinstance(model.config, ModelConfigPM)
    assert isinstance(model.config, BaseModel)
    assert model.config.models_dir == "./models"
    assert model.config.modelName == "linear_regression.v0.0.1-240101"
    assert model.config.threshold == 0.5

    logger.info("Done: Initialization of 'SimpleModel'.")


@pytest.mark.parametrize(
    "X_train, y_train, X_test, y_test, r2_score, threshold, is_similar",
    [
        (
            np.array([[1], [2], [3], [4], [5]]),
            np.array([2, 4, 6, 8, 10]),
            np.array([[6], [7], [8]]),
            np.array([12, 14, 16]),
            1,
            0.9,
            True,
        ),
        (
            np.array([[1], [2], [3], [4], [5]]),
            np.array([2, 3, 4, 5, 6]),
            np.array([[6], [7], [8]]),
            np.array([7, 8, 9]),
            1,
            0.1,
            True,
        ),
    ],
)
def test_train_predict(
    model: SimpleModel,
    X_train: NDArray[Any],
    y_train: NDArray[Any],
    X_test: NDArray[Any],
    y_test: NDArray[Any],
    r2_score: float,
    threshold: Union[float, None],
    is_similar: bool,
) -> None:
    logger.info("Testing training and prediction of 'SimpleModel'...")

    model.train(X=X_train, y=y_train)
    assert model.is_trained()

    _y_pred: NDArray[Any] = model.predict(X=X_test)
    assert isinstance(_y_pred, np.ndarray)
    assert _y_pred.shape == y_test.shape
    assert np.allclose(_y_pred, y_test)
    assert model.score(y_true=y_test, y_pred=_y_pred) == r2_score
    assert model.is_similar(X=X_test, y=y_test, threshold=threshold) == is_similar

    logger.info("Done: Training and prediction of 'SimpleModel'.")


def test_errors(model: SimpleModel) -> None:
    logger.info("Testing exceptions in 'SimpleModel'...")

    with pytest.raises(TypeError):
        model.model = "Model"
        model.config = None

    with pytest.raises(ValidationError):
        model.config = {"models_dir": 123, "modelName": "Model"}
        model.config = ModelConfigPM(models_dir=123, modelName="Model")

    logger.info("Done: Exceptions in 'SimpleModel'.")
