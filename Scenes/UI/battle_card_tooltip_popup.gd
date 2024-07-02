class_name BattleCardTooltipPopup
extends Control

const CARD_MENU_UI_SCENE := preload("res://Scenes/UI/battle_card_menu_ui.tscn")

@onready var tooltip_card: CenterContainer = %TooltipCard
@onready var card_description: RichTextLabel = %CardDescription

func _ready() -> void:
	for card: BattleCardMenuUI in tooltip_card.get_children():
		card.queue_free()
	
	hide_tooltip()
	await get_tree().create_timer(3.0).timeout
	show_tooltip(preload("res://Characters/Ground Combat/punch_attack.tres"))

func show_tooltip(battle_card: BattleCard) -> void:
	var new_card := CARD_MENU_UI_SCENE.instantiate() as BattleCardMenuUI
	tooltip_card.add_child(new_card)
	new_card.battle_card = battle_card
	new_card.tooltip_requested.connect(hide_tooltip.unbind(1))
	card_description.text = battle_card.tooltip_text
	show()

func hide_tooltip() -> void:
	if not visible:
		return
	
	for card: BattleCardMenuUI in tooltip_card.get_children():
		card.queue_free()
	
	hide()

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouses"):
		hide_tooltip()
