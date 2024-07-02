class_name BattleCardPile
extends Resource

signal card_pile_size_changed(cards_amount)

@export var battle_cards: Array[BattleCard] = []

func empty() -> bool:
	return battle_cards.is_empty()

func draw_card() -> BattleCard:
	var battle_card = battle_cards.pop_front()
	card_pile_size_changed.emit(battle_cards.size())
	return battle_card

func add_card(card: BattleCard):
	battle_cards.append(card)
	card_pile_size_changed.emit(battle_cards.size())
	
func shuffle() -> void:
	battle_cards.shuffle()

func clear() -> void:
	battle_cards.clear()
	card_pile_size_changed.emit(battle_cards.size())

func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(battle_cards.size()):
		_card_strings.append("%s: %s" % [i+1, battle_cards[i].id])
	return "\n".join(_card_strings)
