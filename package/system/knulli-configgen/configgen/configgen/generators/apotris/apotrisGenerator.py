from __future__ import annotations
from pathlib import Path
from typing import TYPE_CHECKING

from ...Command import Command
from ...controller import generate_sdl_game_controller_config
from ..Generator import Generator

if TYPE_CHECKING:
    from ...types import HotkeysContext

class ApotrisGenerator(Generator):
    command = "Apotris"

    def getHotkeysContext(self) -> HotkeysContext:
        return {"name": "apotris",
                "keys": {"exit": f"killall {self.command}"}}

    def generate(self, system, rom, playersControllers, metadata, guns, wheels, gameResolution):
        return Command(array=[self.command],
                       env={"SDL_GAMECONTROLLERCONFIG": generate_sdl_game_controller_config(playersControllers)})

    def executionDirectory(self, config, rom):
        return str(Path(rom).parent)
