class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats
@export var persuasion_stats: PersuasionStats

@onready var battle_card_ui := preload("res://Scenes/Card UI/battle_card_ui.tscn")
@onready var persuasion_card_ui := preload("res://Scenes/Card UI/persuasion_card_ui.tscn")

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

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	child.parent = self
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
