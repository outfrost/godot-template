@tool
class_name BakedCSGMesh
extends MeshInstance3D

@export var bake: bool = false:
	set = bake_geometry
@export var clear: bool = false:
	set = clear_geometry

var csg_child_count: = 0
var csg_child: CSGShape3D = null

func _ready() -> void:
	child_order_changed.connect(check_children)
	check_children()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: = PackedStringArray()
	if csg_child_count != 1:
		warnings.append("This node must have exactly one CSG child in order to function.")
	else:
		if csg_child && csg_child.transform != Transform3D.IDENTITY:
			warnings.append("The CSG child node's transform must equal identity (default)."
				+ " BakedCSGMesh cannot apply a child transform to the baked mesh.")
	return warnings

func check_children() -> void:
	csg_child_count = 0
	for child in get_children():
		if child is CSGShape3D:
			csg_child_count += 1
			csg_child = child
	update_configuration_warnings()

func bake_geometry(_ignore) -> void:
	if csg_child_count != 1:
		push_error("Cannot bake CSG mesh: Node must have exactly one CSG child")
		return
	csg_child.show()
	var csg_data: = csg_child.get_meshes()
	mesh = csg_data[1]
	ResourceSaver
	csg_child.hide()
	print("Baked CSG mesh")
	update_configuration_warnings()

func clear_geometry(_ignore) -> void:
	mesh = null
	if csg_child:
		csg_child.show()
