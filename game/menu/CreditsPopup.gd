extends Popup

func _ready() -> void:
	$Panel/RichTextLabel.connect("meta_clicked", self, "on_meta_clicked")
	$Panel/RichTextLabel2.connect("meta_clicked", self, "on_meta_clicked")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		hide()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			hide()

func on_meta_clicked(meta: String):
	if meta.begins_with("http"):
		OS.shell_open(meta)
