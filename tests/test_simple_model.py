# -*- coding: utf-8 -*-

import logging
from typing import Any, Generator

import pytest
import numpy as np
from numpy.typing import NDArray

try:
    from simple_model import SimpleModel
except ImportError:
    from src.simple_model import SimpleModel


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

    logger.info("Done: Initialization of 'SimpleModel'.")
