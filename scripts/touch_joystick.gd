extends Control
## On-screen joystick for phones and tablets. Feeds the same move actions as the
## keyboard, so gameplay code never needs to know which one is in use. Touches it
## claims are consumed so the camera only sees touches elsewhere on screen.

@export var radius := 70.0

var _finger := -1
var _origin := Vector2.ZERO
var _knob := Vector2.ZERO


func _ready() -> void:
	visible = DisplayServer.is_touchscreen_available()
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event is InputEventScreenTouch:
		if event.pressed and _finger == -1 and get_global_rect().has_point(event.position):
			_finger = event.index
			_origin = event.position
			_set_knob(Vector2.ZERO)
			get_viewport().set_input_as_handled()
		elif not event.pressed and event.index == _finger:
			_finger = -1
			_set_knob(Vector2.ZERO)
			get_viewport().set_input_as_handled()
	elif event is InputEventScreenDrag and event.index == _finger:
		_set_knob((event.position - _origin).limit_length(radius))
		get_viewport().set_input_as_handled()


func _set_knob(offset: Vector2) -> void:
	_knob = offset
	var v := offset / radius
	_apply("move_right", maxf(v.x, 0.0))
	_apply("move_left", maxf(-v.x, 0.0))
	_apply("move_back", maxf(v.y, 0.0))
	_apply("move_forward", maxf(-v.y, 0.0))
	queue_redraw()


func _apply(action: String, strength: float) -> void:
	if strength > 0.05:
		Input.action_press(action, strength)
	else:
		Input.action_release(action)


func _draw() -> void:
	if _finger == -1:
		var center := size * 0.5
		draw_circle(center, radius, Color(0.8, 0.7, 0.55, 0.12))
		draw_circle(center, 28.0, Color(0.8, 0.7, 0.55, 0.3))
	else:
		var local_origin := _origin - global_position
		draw_circle(local_origin, radius, Color(0.8, 0.7, 0.55, 0.15))
		draw_circle(local_origin + _knob, 28.0, Color(0.9, 0.8, 0.6, 0.45))
