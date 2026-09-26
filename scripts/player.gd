extends CharacterBody3D
## Third-person player: camera-relative movement, gravity and jumping.

@export var move_speed := 6.0
@export var turn_speed := 12.0
@export var jump_velocity := 5.0

@onready var camera_rig: CameraRig = $CameraRig
@onready var body: Node3D = $Body

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var yaw_basis := Basis(Vector3.UP, camera_rig.yaw)
	var direction := (yaw_basis * Vector3(input.x, 0.0, input.y))
	if direction.length() > 1.0:
		direction = direction.normalized()

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed

	if direction.length() > 0.05:
		var target_yaw := atan2(-direction.x, -direction.z)
		body.rotation.y = lerp_angle(body.rotation.y, target_yaw, turn_speed * delta)

	move_and_slide()
