class_name PlayerPersuasionHandler
extends Node

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var persuasion_stats: PersuasionStats

func start_persuasion(given_stats: PersuasionStats) -> void:
	persuasion_stats = given_stats
	persuasion_stats.draw_pile = persuasion_stats.deck.duplicate(true)
	persuasion_stats.draw_pile.shuffle()
	persuasion_stats.discard = CardPile.new()
	Events.card_discarded.connect(_on_card_discard_requested)
	start_turn()

func start_turn() -> void:
	draw_cards()

func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_persuasion_card(persuasion_stats.draw_pile.draw_card())
	reshuffle_deck_from_discard()

#Draw cards up to hand_size
func draw_cards() -> void:
	var tween := create_tween()
	for i in range(persuasion_stats.hand_size - hand.get_children().size()):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)

func reshuffle_deck_from_discard() -> void:
	if not persuasion_stats.draw_pile.empty():
		return

	while not persuasion_stats.discard.empty():
		persuasion_stats.draw_pile.add_card(persuasion_stats.discard.draw_card())
	
	persuasion_stats.draw_pile.shuffle()

func discard_selected_cards() -> void:
	hand.discard_selected_cards()

func _on_card_discard_requested(card: Card) -> void:
	persuasion_stats.discard.add_card(card)
