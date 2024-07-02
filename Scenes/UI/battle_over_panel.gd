class_name BattleOverPanel
extends Panel

enum Type {WIN, LOSE}

var type: Type

@onready var label: Label =  %Label
@onready var continue_button: Button = %ContinueButton

func _ready() -> void:
	continue_button.pressed.connect(func(): Events.battle_won.emit())
	Events.battle_over_screen_requested.connect(show_screen)

func show_screen(text: String, type: Type) -> void:
	label.text = text
	continue_button.visible = true
	show()
	get_tree().paused = true
	self.type = type

func handle_continue_button_pressed() -> void:
	if type == Type.WIN:
		Events.battle_won.emit()
	elif type == Type.LOSE:
		Events.battle_lost.emit()
