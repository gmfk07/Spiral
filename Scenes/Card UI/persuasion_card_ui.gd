class_name PersuasionCardUI
extends CardUI

signal reparent_requested(which_card_ui: BattleCardUI)

const BASE_STYLEBOX := preload("res://Scenes/Card UI/card_base_style_box.tres")
const HOVER_STYLEBOX := preload("res://Scenes/Card UI/card_hover_style_box.tres")

@export var persuasion_card: PersuasionCard : set = _set_card
@export var persuasion_stats: PersuasionStats : set = _set_stats

@onready var panel = $Panel
@onready var value = $Value
@onready var icon = $Icon

func select() -> void:
	Events.card_selected.emit(self)

func deselect() -> void:
	Events.card_deselected.emit(self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_state_machine = $CardStateMachine as CardStateMachine
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _set_card(card: PersuasionCard) -> void:
	if not is_node_ready():
		await ready

	persuasion_card = card
	value.text = str(card.value)
	icon.texture = card.icon
	
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

func _set_stats(stats: PersuasionStats) -> void:
	persuasion_stats = stats
	persuasion_stats.stats_changed.connect(_on_persuasion_stats_changed)

func _on_persuasion_stats_changed() -> void:
	pass
