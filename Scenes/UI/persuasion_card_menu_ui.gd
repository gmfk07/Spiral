class_name PersuasionCardMenuUI
extends CenterContainer

signal tooltip_requested(card: Card)

@export var persuasion_card: PersuasionCard : set = set_persuasion_card

@onready var panel: Panel = $Visuals/Panel
@onready var value: Label = $Visuals/Value
@onready var icon: TextureRect = $Visuals/Icon

func _ready():
	var style_box: StyleBoxFlat = panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.00))
	style_box.set("shadow_size", 2)
	panel.add_theme_stylebox_override("panel", style_box)

func _on_visuals_gui_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		tooltip_requested.emit(persuasion_card)

func _on_visuals_mouse_entered():
	var style_box: StyleBoxFlat = panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.47))
	style_box.set("shadow_size", 2)
	panel.add_theme_stylebox_override("panel", style_box)

func _on_visuals_mouse_exited():
	var style_box: StyleBoxFlat = panel.get_theme_stylebox("panel").duplicate()
	style_box.set("shadow_color", Color(0.80, 0.80, 0.45, 0.00))
	style_box.set("shadow_size", 2)
	panel.add_theme_stylebox_override("panel", style_box)

func set_persuasion_card(given_card: PersuasionCard):
	if not is_node_ready():
		await ready
	
	persuasion_card = given_card
	value.text = str(persuasion_card.value)
	icon.texture = persuasion_card.icon

	var styleBox: StyleBoxFlat = panel.get_theme_stylebox("panel").duplicate()
	
	if persuasion_card.suit == persuasion_card.Suit.RATIONAL:
		styleBox.set("bg_color", Color.DARK_BLUE)
	if persuasion_card.suit == persuasion_card.Suit.EMOTIONAL:
		styleBox.set("bg_color", Color.DARK_GOLDENROD)
	if persuasion_card.suit == persuasion_card.Suit.AGGRESSIVE:
		styleBox.set("bg_color", Color.DARK_RED)
	if persuasion_card.suit == persuasion_card.Suit.FRIENDLY:
		styleBox.set("bg_color", Color.DARK_GREEN)
		
	panel.add_theme_stylebox_override("panel", styleBox)
