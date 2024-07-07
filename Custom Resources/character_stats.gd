class_name CharacterStats
extends BattleStats

@export var starting_deck: CardPile
@export var cards_per_turn: int
@export var max_energy: int

var energy: int: set = set_energy
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func set_energy(value: int) -> void:
	energy = value
	stats_changed.emit()

func reset_energy() -> void:
	self.energy = max_energy

func take_damage(damage: int) -> void:
	var initial_health := health
	super.take_damage(damage)
	
	if initial_health > health:
		Events.player_hit.emit()

func can_play_battle_card(battle_card: BattleCard) -> bool:
	return energy >= battle_card.cost

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.evade = 0
	instance.reset_energy()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
