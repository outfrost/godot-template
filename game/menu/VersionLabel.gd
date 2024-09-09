class_name VersionLabel
extends Label

const VERSION_PATH: = "res://version.tres"

func _ready() -> void:
	var v = FileAccess.get_file_as_string(VERSION_PATH)
	if FileAccess.get_open_error() != OK:
		push_error("cannot open version file")
		text = ""
	else:
		text = v.rstrip("\n").rstrip("\r")

	if OS.has_feature("debug"):
		text += " (DEBUG)"
