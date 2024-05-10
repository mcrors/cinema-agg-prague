import logging
import sys


_logger = None


def get_logger() -> logging.Logger:
    global _logger
    if _logger is not None:
        return _logger

    _logger = logging.getLogger("scraper")
    _logger.setLevel(logging.INFO)
    handler = logging.StreamHandler(sys.stdout)
    formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(filename)s - %(message)s")
    handler.setFormatter(formatter)
    _logger.addHandler(handler)
    return _logger

