extends CardState

const SELECTED_Y_OFFSET = 32
const ANIMATION_TIME = 0.2

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var offset := Vector2(0, -SELECTED_Y_OFFSET)
	card_ui.animate_to_position(card_ui.parent.global_position + offset, ANIMATION_TIME)
	get_tree().create_timer(ANIMATION_TIME, false).timeout.connect(func(): transition_requested.emit(self, CardState.State.BASE))
