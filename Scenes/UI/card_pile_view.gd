class_name CardPileView
extends Control

const BATTLE_CARD_MENU_UI_SCENE := preload("res://Scenes/UI/battle_card_menu_ui.tscn")

@export var card_pile: CardPile

@onready var title: Label = %Title
@onready var cards: GridContainer = %Cards
@onready var card_tooltip_popup: CardTooltipPopup = %CardTooltipPopup
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(hide)

	for card: Node in cards.get_children():
		card.queue_free()
	
	card_tooltip_popup.hide_tooltip()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if card_tooltip_popup.visible:
			card_tooltip_popup.hide_tooltip()
		else:
			hide()

func show_current_view(new_title: String, randomized: bool = false) -> void:
	for card: Node in cards.get_children():
		card.queue_free()
	
	card_tooltip_popup.hide_tooltip()
	title.text = new_title
	_update_view.call_deferred(randomized)

func _update_view(randomized: bool) -> void:
	if not card_pile:
		return
	
	var all_cards: Array[Card] = card_pile.cards.duplicate()
	if randomized:
		all_cards.shuffle()

	for card: Card in all_cards:
		if card is BattleCard:
			var new_card := BATTLE_CARD_MENU_UI_SCENE.instantiate() as BattleCardMenuUI
			cards.add_child(new_card)
			new_card.battle_card = card
			new_card.tooltip_requested.connect(card_tooltip_popup.show_tooltip)
	
	show()
