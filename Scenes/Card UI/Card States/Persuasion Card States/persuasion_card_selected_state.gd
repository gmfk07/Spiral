extends CardState

const SELECTED_Y_OFFSET = 32
const ANIMATION_TIME = 0.2

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var offset := Vector2(0, SELECTED_Y_OFFSET)
	card_ui.animate_to_position(card_ui.global_position + offset, ANIMATION_TIME)

func on_gui_input(event: InputEvent) -> void:	
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, CardState.State.CLICKED)
