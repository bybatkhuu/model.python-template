import os
import logging
from unittest.mock import MagicMock, patch

import pytest
import numpy as np
from sklearn.linear_model import LinearRegression

try:
    from {{cookiecutter.module_name}} import SimpleModel, ModelConfigPM
except ImportError:
    from src.{{cookiecutter.module_name}} import SimpleModel, ModelConfigPM

logger = logging.getLogger(__name__)


@pytest.fixture
def config():
    """Fixture for a default configuration mock."""
    config = ModelConfigPM()
    config.models_dir = "models"
    config.modelName = "test_model"
    config.threshold = 0.5
    return config


@pytest.fixture
def model(config):
    """Fixture to initialize SimpleModel with default config."""
    return SimpleModel(config=config, auto_load=False)


def test_initialization(model):
    """Test initialization and default settings."""
    assert isinstance(model.config, ModelConfigPM)
    assert isinstance(model.model, LinearRegression)


def test_is_model_files_exist(model, config):
    """Test model file existence check."""
    with patch("os.path.isdir") as mock_isdir, patch("os.path.isfile") as mock_isfile:
        mock_isdir.return_value = True
        mock_isfile.return_value = True
        assert model.is_model_files_exist(config.models_dir, config.modelName)


def test_train(model):
    """Test model training."""
    X = np.array([[1, 2], [2, 3], [3, 4]])
    y = np.array([1, 2, 3])
    model.train(X, y)
    assert hasattr(model.model, "coef_"), "Model should be trained."


def test_predict(model):
    """Test prediction after training."""
    X = np.array([[1, 2], [2, 3], [3, 4]])
    y = np.array([1, 2, 3])
    model.train(X, y)
    predictions = model.predict(X)
    assert len(predictions) == len(y), "Predictions length should match input length."


def test_score(model):
    """Test R^2 score calculation."""
    y_true = np.array([1, 2, 3])
    y_pred = np.array([1.1, 2.0, 2.9])
    score = model.score(y_true, y_pred)
    assert 0.9 <= score <= 1.0, "Score should be close to 1 for similar predictions."


def test_is_similar(model, config):
    """Test similarity check against a threshold."""
    X = np.array([[1, 2], [2, 3], [3, 4]])
    y = np.array([1, 2, 3])
    model.train(X, y)
    assert model.is_similar(X, y, threshold=0.5)


def test_is_trained(model):
    """Test if model is trained."""
    X = np.array([[1, 2], [2, 3], [3, 4]])
    y = np.array([1, 2, 3])
    assert not model.is_trained(), "Model should not be trained initially."
    model.train(X, y)
    assert model.is_trained(), "Model should be trained after training."


def test_save_model(model, config):
    """Test saving the trained model."""
    with (
        patch("builtins.open", new_callable=MagicMock) as mock_open,
        patch("pickle.dump") as mock_pickle_dump,
        patch("os.path.isdir", return_value=True),
        patch("os.path.isfile", return_value=True),
    ):

        model.train(np.array([[1, 2], [2, 3], [3, 4]]), np.array([1, 2, 3]))
        model.save()
        mock_open.assert_called_once_with(
            os.path.join(config.models_dir, config.modelName, "model.pkl"), "wb"
        )
        mock_pickle_dump.assert_called_once()


def test_load_model(model, config):
    """Test loading a saved model."""

    with (
        patch("builtins.open", new_callable=MagicMock) as mock_open,
        patch("pickle.load") as mock_pickle_load,
        patch("os.path.isdir", return_value=True),
        patch("os.path.isfile", return_value=True),
    ):

        mock_pickle_load.return_value = LinearRegression()
        model.load()
        mock_open.assert_called_once_with(
            os.path.join(config.models_dir, config.modelName, "model.pkl"), "rb"
        )
