extends SceneTree
## Headless smoke test: loads the main scene, holds "move_forward" for a second
## and checks the player landed on the ground and moved. Run with:
##   godot --headless -s tests/smoke_test.gd

func _initialize() -> void:
	var main: Node = load("res://scenes/main.tscn").instantiate()
	root.add_child(main)
	var player: CharacterBody3D = main.get_node("Player")

	for i in 60:
		await physics_frame
	var start := player.global_position
	Input.action_press("move_forward")
	for i in 60:
		await physics_frame
	Input.action_release("move_forward")

	var moved := start.distance_to(player.global_position)
	var ok := player.is_on_floor() and moved > 3.0
	print("smoke test: moved %.2f m, on floor %s -> %s" % [moved, player.is_on_floor(), "PASS" if ok else "FAIL"])
	quit(0 if ok else 1)
