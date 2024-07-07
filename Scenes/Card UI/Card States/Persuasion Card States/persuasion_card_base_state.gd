extends CardState

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready

	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()

	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO
	Events.tooltip_hide_requested.emit()
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, CardState.State.SELECTED)

func on_mouse_entered() -> void:
	var style_box: StyleBoxFlat = card_ui.panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.47))
	style_box.set("shadow_size", 2)
	card_ui.panel.add_theme_stylebox_override("panel", style_box)
	
func on_mouse_exited() -> void:
	var style_box: StyleBoxFlat = card_ui.panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.00))
	card_ui.panel.add_theme_stylebox_override("panel", style_box)
