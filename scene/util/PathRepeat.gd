@tool
class_name PathRepeat
extends Path3D

@export var repeated_scene: PackedScene:
	set(scn):
		if scn:
			var scene_instance = scn.instantiate()
			if !(scene_instance is Node3D):
				push_error("Repeated Scene's root node must be or inherit from Node3D")
				scene_instance.queue_free()
				return
			scene_instance.queue_free()
		repeated_scene = scn
		regenerate.call_deferred()
@export var interval: float = 1.0:
	set(v):
		interval = v
		if v < 0.0:
			interval = 0.0
		refresh.call_deferred()
@export var offset: float = 0.0:
	set(v):
		offset = v
		refresh.call_deferred()
@export var rotated: bool = true:
	set(v):
		rotated = v
		refresh.call_deferred()

var repeat_container: Node3D
var instance_pool: Array = []

func _ready() -> void:
	repeat_container = Node3D.new()
	add_child(repeat_container, false, Node.INTERNAL_MODE_FRONT)
	curve_changed.connect(refresh)

func has_valid_parameters() -> bool:
	return repeated_scene && interval >= 0.1

func regenerate() -> void:
	if !is_node_ready():
		return

	for scene_instance in instance_pool:
		if repeat_container.is_ancestor_of(scene_instance):
			repeat_container.remove_child(scene_instance)
		scene_instance.queue_free()
	instance_pool.clear()

	if !has_valid_parameters():
		return

	var current_travel: = 0.0
	while current_travel <= curve.get_baked_length():
		var scene_instance: Node3D = repeated_scene.instantiate()
		instance_pool.append(scene_instance)
		if rotated:
			scene_instance.transform = curve.sample_baked_with_rotation(current_travel + offset, true)
		else:
			scene_instance.transform = Transform3D.IDENTITY.translated(curve.sample_baked(current_travel + offset, false))
		repeat_container.add_child(scene_instance)
		current_travel += interval

func refresh() -> void:
	if !is_node_ready():
		return

	var i: = 0
	if has_valid_parameters():
		var current_travel: = 0.0
		while current_travel <= curve.get_baked_length():
			var scene_instance: Node3D
			if i == instance_pool.size():
				scene_instance = repeated_scene.instantiate()
				instance_pool.append(scene_instance)
				repeat_container.add_child(scene_instance)
			else:
				scene_instance = instance_pool[i]
				if !repeat_container.is_ancestor_of(scene_instance):
					repeat_container.add_child(scene_instance)
			if rotated:
				scene_instance.transform = curve.sample_baked_with_rotation(current_travel + offset, true)
			else:
				scene_instance.transform = Transform3D.IDENTITY.translated(curve.sample_baked(current_travel + offset, false))
			current_travel += interval
			i += 1

	for k in range(i, instance_pool.size()):
		if repeat_container.is_ancestor_of(instance_pool[k]):
			repeat_container.remove_child(instance_pool[k])

	# shrink pool if fewer than half the instances are in use
	var halfsize: = instance_pool.size() / 2
	if i < halfsize:
		for k in range(halfsize, instance_pool.size()):
			instance_pool[k].queue_free()
		instance_pool.resize(halfsize)
