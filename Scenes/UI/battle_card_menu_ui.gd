class_name BattleCardMenuUI
extends CenterContainer

signal tooltip_requested(card: Card)

const BASE_STYLEBOX := preload("res://Scenes/Card UI/card_base_style_box.tres")
const HOVER_STYLEBOX := preload("res://Scenes/Card UI/card_hover_style_box.tres")

@export var battle_card: BattleCard : set = set_battle_card

@onready var panel: Panel = $Visuals/Panel
@onready var cost: Label = $Visuals/Cost
@onready var icon: TextureRect = $Visuals/Icon

func _ready():
	panel.set("theme_override_styles/panel", BASE_STYLEBOX)

func _on_visuals_gui_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		tooltip_requested.emit(battle_card)

func _on_visuals_mouse_entered():
	panel.set("theme_override_styles/panel", HOVER_STYLEBOX)

func _on_visuals_mouse_exited():
	panel.set("theme_override_styles/panel", BASE_STYLEBOX)

func set_battle_card(value: BattleCard):
	if not is_node_ready():
		await ready
	
	battle_card = value
	cost.text = str(battle_card.cost)
	icon.texture = battle_card.icon
