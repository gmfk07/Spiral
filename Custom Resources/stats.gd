class_name Stats
extends Resource

signal stats_changed

@export var max_health := 1
@export var art: Texture

var health: int : set = set_health
var evade: int : set = set_evade

func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()

func set_evade(value : int) -> void:
	evade = clampi(value, 0, 999)
	stats_changed.emit()

func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - evade, 0, damage)
	self.evade = clampi(evade - initial_damage, 0, evade)
	self.health -= damage

func heal(amount : int) -> void:
	self.health += amount

func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.evade = 0
	return instance
