extends Node3D
## Scatters placeholder props (dead trees, rocks, torches) around the test level.
## Uses a fixed seed so the layout is the same on every run.

@export var area := 90.0
@export var tree_count := 140
@export var rock_count := 80
@export var torch_count := 10

var _bark := _material(Color(0.16, 0.13, 0.11))
var _stone := _material(Color(0.3, 0.3, 0.32))
var _iron := _material(Color(0.12, 0.12, 0.13))
var _flame := _emissive(Color(1.0, 0.55, 0.2))
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	_rng.seed = 1996
	for i in tree_count:
		_add_dead_tree(_random_point(8.0))
	for i in rock_count:
		_add_rock(_random_point(4.0))
	for i in torch_count:
		var angle := TAU * i / torch_count
		_add_torch(Vector3(cos(angle), 0.0, sin(angle)) * 14.0)


func _random_point(clear_radius: float) -> Vector3:
	while true:
		var p := Vector3(_rng.randf_range(-area, area), 0.0, _rng.randf_range(-area, area))
		if p.length() > clear_radius:
			return p
	return Vector3.ZERO


func _add_dead_tree(pos: Vector3) -> void:
	var height := _rng.randf_range(3.0, 7.0)
	var tree := _static_body(pos, CylinderShape3D.new(), Vector3(0, height * 0.5, 0))
	(tree.get_child(0).shape as CylinderShape3D).radius = 0.3
	(tree.get_child(0).shape as CylinderShape3D).height = height

	var trunk := CylinderMesh.new()
	trunk.top_radius = 0.08
	trunk.bottom_radius = 0.35
	trunk.height = height
	_mesh(tree, trunk, _bark, Vector3(0, height * 0.5, 0), Vector3(_rng.randf_range(-0.1, 0.1), 0, _rng.randf_range(-0.1, 0.1)))

	for b in _rng.randi_range(2, 4):
		var branch := CylinderMesh.new()
		branch.top_radius = 0.02
		branch.bottom_radius = 0.1
		branch.height = _rng.randf_range(1.0, 2.2)
		var y := _rng.randf_range(height * 0.45, height * 0.9)
		var rot := Vector3(0, _rng.randf() * TAU, deg_to_rad(_rng.randf_range(40, 70)))
		_mesh(tree, branch, _bark, Vector3(0, y, 0), rot)


func _add_rock(pos: Vector3) -> void:
	var s := _rng.randf_range(0.4, 1.6)
	var shape := SphereShape3D.new()
	shape.radius = s * 0.8
	var rock := _static_body(pos, shape, Vector3(0, s * 0.2, 0))
	var mesh := SphereMesh.new()
	mesh.radius = s
	mesh.height = s * 1.1
	mesh.radial_segments = 7
	mesh.rings = 3
	_mesh(rock, mesh, _stone, Vector3(0, s * 0.2, 0), Vector3(0, _rng.randf() * TAU, 0))


func _add_torch(pos: Vector3) -> void:
	var shape := CylinderShape3D.new()
	shape.radius = 0.12
	shape.height = 2.2
	var torch := _static_body(pos, shape, Vector3(0, 1.1, 0))
	var post := CylinderMesh.new()
	post.top_radius = 0.07
	post.bottom_radius = 0.1
	post.height = 2.2
	_mesh(torch, post, _iron, Vector3(0, 1.1, 0), Vector3.ZERO)
	var fire := SphereMesh.new()
	fire.radius = 0.16
	fire.height = 0.4
	_mesh(torch, fire, _flame, Vector3(0, 2.35, 0), Vector3.ZERO)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.6, 0.3)
	light.light_energy = 2.2
	light.omni_range = 9.0
	light.position = Vector3(0, 2.5, 0)
	torch.add_child(light)


func _static_body(pos: Vector3, shape: Shape3D, shape_offset: Vector3) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.position = pos
	var col := CollisionShape3D.new()
	col.shape = shape
	col.position = shape_offset
	body.add_child(col)
	add_child(body)
	return body


func _mesh(parent: Node3D, mesh: Mesh, mat: Material, pos: Vector3, rot: Vector3) -> void:
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = pos
	mi.rotation = rot
	parent.add_child(mi)


static func _material(color: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.roughness = 0.95
	return m


static func _emissive(color: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.emission_enabled = true
	m.emission = color
	m.emission_energy_multiplier = 3.0
	return m
