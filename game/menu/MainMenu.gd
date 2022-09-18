# Copyright 2021 Outfrost
# This work is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the LICENSE file for more details.

extends Control

signal start_game()

@onready var play_button: Button = %PlayButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton
@onready var credits_popup: Control = $CreditsPopup

func _ready() -> void:
	play_button.pressed.connect(func(): self.start_game.emit())
	credits_button.pressed.connect(credits_popup.show)
	quit_button.pressed.connect(func(): get_tree().quit())
