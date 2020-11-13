extends Control

signal start_game()

onready var play_button: Button = $VBoxContainer/PlayButton
onready var credits_button: Button = $VBoxContainer/CreditsButton
onready var quit_button: Button = $VBoxContainer/QuitButton
onready var credits_popup: Popup = $CreditsPopup

func _ready() -> void:
	play_button.connect("pressed", self, "on_play_pressed")
	credits_button.connect("pressed", self, "on_credits_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func on_play_pressed() -> void:
	emit_signal("start_game")

func on_credits_pressed() -> void:
	credits_popup.show()

func on_quit_pressed() -> void:
	get_tree().quit()
