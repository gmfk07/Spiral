class_name BetWidgetUI
extends HBoxContainer

signal bet_changed(bet: int)

@onready var bet_label: Label = %BetLabel
@onready var subtract_button: TextureButton = %SubtractButton
@onready var add_button: TextureButton = %AddButton

@export var max_bet := 5 : set = _set_max_bet

var bet := 0 : set = _set_bet

func _ready():
	recalculate_buttons_disabled()

func recalculate_buttons_disabled():
	if bet >= max_bet:
		add_button.disabled = true
	else:
		add_button.disabled = false
	
	if bet <= 0:
		subtract_button.disabled = true
	else:
		subtract_button.disabled = false

func _set_max_bet(value: int):
	recalculate_buttons_disabled()

func _set_bet(value: int):
	bet = value
	bet_changed.emit(value)
	bet_label.text = "Bet: " + str(bet)
	recalculate_buttons_disabled()

func _on_subtract_button_pressed():
	bet -= 1

func _on_add_button_pressed():
	bet += 1
