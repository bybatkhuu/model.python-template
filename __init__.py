# flake8: noqa

try:
    from .src.simple_model import *
except ImportError:
    from src.simple_model import *
