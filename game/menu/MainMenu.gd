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
