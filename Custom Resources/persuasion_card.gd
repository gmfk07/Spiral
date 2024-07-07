class_name PersuasionCard
extends Card

enum Suit {RATIONAL, EMOTIONAL, AGGRESSIVE, FRIENDLY}

@export var suit: Suit
@export var value: int

func apply_effects() -> void:
	pass
