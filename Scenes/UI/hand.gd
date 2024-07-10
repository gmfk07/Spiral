class_name Hand
extends HBoxContainer

const MAX_SELECTED_CARDS := 5

@export var char_stats: CharacterStats
@export var persuasion_stats: PersuasionStats

@onready var battle_card_ui := preload("res://Scenes/Card UI/battle_card_ui.tscn")
@onready var persuasion_card_ui := preload("res://Scenes/Card UI/persuasion_card_ui.tscn")

var selected_card_ui_array := []

func _ready():
	Events.card_selected.connect(_on_card_selected)
	Events.card_deselected.connect(_on_card_deselected)

func add_battle_card(battle_card: BattleCard) -> void:
	var new_card_ui := battle_card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.battle_card = battle_card
	new_card_ui.reparent(self)
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats

func add_persuasion_card(persuasion_card: PersuasionCard) -> void:
	var new_card_ui := persuasion_card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.persuasion_card = persuasion_card
	new_card_ui.reparent(self)
	new_card_ui.parent = self
	new_card_ui.persuasion_stats = persuasion_stats

func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

func is_selection_full() -> bool:
	return selected_card_ui_array.size() >= MAX_SELECTED_CARDS

func discard_selected_cards() -> void:
	for card_ui in selected_card_ui_array:
		Events.card_discarded.emit(card_ui.persuasion_card)
		card_ui.queue_free()
	selected_card_ui_array = []

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	child.parent = self
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)

func _on_card_selected(card_ui: CardUI) -> void:
	selected_card_ui_array.append(card_ui)

func _on_card_deselected(card_ui: CardUI) -> void:
	var index = selected_card_ui_array.find(card_ui)
	selected_card_ui_array.remove_at(index)
