extends Control

func _ready() -> void:
	$Panel/RichTextLabel.meta_clicked.connect(on_meta_clicked)
	$Panel/RichTextLabel2.meta_clicked.connect(on_meta_clicked)
	$Panel/CloseButton.pressed.connect(hide)

func _input(event: InputEvent) -> void:
	if !visible:
		return
	if event.is_action("ui_cancel") && event.is_pressed():
		hide()
		get_tree().root.set_input_as_handled()

func _gui_input(event):
	if (
		event is InputEventMouseButton
		&& event.button_index == MOUSE_BUTTON_LEFT
		&& !event.is_pressed()
	):
		hide()
		accept_event()

func on_meta_clicked(meta: String):
	if meta.begins_with("http"):
		OS.shell_open(meta)
