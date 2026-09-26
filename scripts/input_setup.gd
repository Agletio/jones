extends Node
## Registers input actions in code so the key map stays readable in text diffs.

const KEY_BINDINGS := {
	"move_forward": [KEY_W, KEY_UP],
	"move_back": [KEY_S, KEY_DOWN],
	"move_left": [KEY_A, KEY_LEFT],
	"move_right": [KEY_D, KEY_RIGHT],
	"jump": [KEY_SPACE],
	"target_next": [KEY_TAB],
}


func _enter_tree() -> void:
	for action in KEY_BINDINGS:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for keycode in KEY_BINDINGS[action]:
			var ev := InputEventKey.new()
			ev.physical_keycode = keycode
			InputMap.action_add_event(action, ev)
