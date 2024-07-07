class_name PersuasionStats
extends Resource

@export var starting_deck: CardPile
@export var hand_size: int

var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

signal stats_changed

@export var chips := 15

func create_instance() -> Resource:
	var instance: PersuasionStats = self.duplicate()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
