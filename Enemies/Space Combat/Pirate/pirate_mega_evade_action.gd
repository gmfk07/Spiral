extends EnemyAction

@export var evade := 15
@export var hp_threshold := 6

var already_used := false

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_hp_low := enemy.stats.health <= hp_threshold
	already_used = is_hp_low
	
	return is_hp_low

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var evade_effect := EvadeEffect.new()
	evade_effect.amount = evade
	evade_effect.sound = sound
	evade_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
