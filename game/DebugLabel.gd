# Copyright 2020 Outfrost
# This work is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the LICENSE.WTFPL file for more details.

class_name DebugLabel
extends Label

var buffer: String = ""

func _ready():
	text = ""

func _process(_delta):
	text = buffer
	buffer = ""

func display_impl(s: String):
	buffer += s + "\n"

static func display(ref, s):
	var label = ref.get_tree().root.find_node("DebugLabel", true, false) as DebugLabel
	if label:
		label.display_impl(s)
