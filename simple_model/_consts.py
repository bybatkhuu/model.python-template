# -*- coding: utf-8 -*-

from enum import Enum


class WarnEnum(str, Enum):
    ERROR = "ERROR"
    ALWAYS = "ALWAYS"
    DEBUG = "DEBUG"
    IGNORE = "IGNORE"


__all__ = ["WarnEnum"]
