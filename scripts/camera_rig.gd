class_name CameraRig
extends Node3D
## Orbit camera that follows its parent. Drag with right mouse (or one finger on
## the right side of a touch screen) to orbit; scroll or pinch to zoom.

@export var min_distance := 3.0
@export var max_distance := 18.0
@export var mouse_sensitivity := 0.006
@export var touch_sensitivity := 0.008
@export var min_pitch := deg_to_rad(-75.0)
@export var max_pitch := deg_to_rad(-8.0)

var yaw := 0.0
var pitch := deg_to_rad(-30.0)
var distance := 9.0

var _touches := {}
var _pinch_start_distance := 0.0
var _pinch_start_zoom := 0.0

@onready var _arm: SpringArm3D = $SpringArm3D
@onready var _target: Node3D = get_parent()


func _ready() -> void:
	top_level = true
	_arm.add_excluded_object(_target.get_rid())


func _process(delta: float) -> void:
	global_position = global_position.lerp(_target.global_position + Vector3.UP * 1.4, clampf(delta * 12.0, 0.0, 1.0))
	rotation = Vector3(pitch, yaw, 0.0)
	_arm.spring_length = lerpf(_arm.spring_length, distance, clampf(delta * 10.0, 0.0, 1.0))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_orbit(event.relative * mouse_sensitivity)
	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance = clampf(distance - 1.0, min_distance, max_distance)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance = clampf(distance + 1.0, min_distance, max_distance)
	elif event is InputEventScreenTouch:
		if event.pressed:
			_touches[event.index] = event.position
		else:
			_touches.erase(event.index)
		if _touches.size() == 2:
			var points: Array = _touches.values()
			_pinch_start_distance = points[0].distance_to(points[1])
			_pinch_start_zoom = distance
	elif event is InputEventScreenDrag and _touches.has(event.index):
		_touches[event.index] = event.position
		if _touches.size() == 1:
			_orbit(event.relative * touch_sensitivity)
		elif _touches.size() == 2 and _pinch_start_distance > 0.0:
			var points: Array = _touches.values()
			var ratio := _pinch_start_distance / maxf(points[0].distance_to(points[1]), 1.0)
			distance = clampf(_pinch_start_zoom * ratio, min_distance, max_distance)


func _orbit(amount: Vector2) -> void:
	yaw -= amount.x
	pitch = clampf(pitch - amount.y, min_pitch, max_pitch)
