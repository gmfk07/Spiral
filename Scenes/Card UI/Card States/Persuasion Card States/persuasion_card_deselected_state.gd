extends CardState

const SELECTED_Y_OFFSET = 32
const ANIMATION_TIME = 0.2

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var offset := Vector2(card_ui.position.x, card_ui.position.y+SELECTED_Y_OFFSET)
	card_ui.animate_to_position(offset, ANIMATION_TIME)
	get_tree().create_timer(ANIMATION_TIME + 0.01, false).timeout.connect(func(): transition_requested.emit(self, CardState.State.BASE))

func on_mouse_entered() -> void:
	var style_box: StyleBoxFlat = card_ui.panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.47))
	style_box.set("shadow_size", 2)
	card_ui.panel.add_theme_stylebox_override("panel", style_box)
	
func on_mouse_exited() -> void:
	var style_box: StyleBoxFlat = card_ui.panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.00))
	card_ui.panel.add_theme_stylebox_override("panel", style_box)
