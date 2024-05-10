from dataclasses import is_dataclass
import inspect
import logging
import os
from types import ModuleType
from typing import Protocol, List

from models import MovieData


class CinemaWebSite(Protocol):

    def get_data(self) -> List[MovieData]:
        ...


class CinemaFactory:

    def __init__(self, logger: logging.Logger):
        self._logger = logger
        self._cinema_dir = os.path.join("app", "cinemas")
        self._cinema_package = "cinemas"

    def get_cinemas(self) -> list[CinemaWebSite]:
        self._logger.info("loading cinemas")
        modules = self._get_modules()
        cinemaObjects = self._create_cinema_objects(modules)
        return cinemaObjects

    def _get_modules(self) -> dict[str, ModuleType]:
        modules = {}
        module_list = os.listdir(self._cinema_dir)
        for module_file in module_list:
            full_path = os.path.abspath(self._cinema_dir) + os.sep + module_file
            if self._is_python_file(full_path) and not self._is_dir_or_init(full_path):
                module_name = os.path.splitext(module_file)[0]
                modules[module_name] = __import__(f'{self._cinema_package}.{module_name}', fromlist=['*'])
        return modules

    def _create_cinema_objects(self, modules: dict[str, ModuleType]) -> list[CinemaWebSite]:
        cinemas = []
        for module in modules:
            for name, obj in inspect.getmembers(modules[module]):
                if inspect.isclass(obj) and not is_dataclass(obj):
                    self._logger.info(f"creating {name} class")
                    instance = obj(self._logger)
                    cinemas.append(instance)
        return cinemas

    @staticmethod
    def _is_python_file(file_path: str) -> bool:
        if file_path.endswith(".py"):
            return True
        return False

    @staticmethod
    def _is_dir_or_init(file_or_folder_path: str) -> bool:
        if os.path.isdir(file_or_folder_path) or os.path.basename(file_or_folder_path) == "__init__.py":
            return True
        return False
