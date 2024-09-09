extends Node

@onready var label: Label = $DebugLabel

var buffer: String = ""

func _ready():
	label.text = ""

func _process(_delta):
	label.text = buffer
	buffer = ""

func display(s: String):
	buffer += s + "\n"
