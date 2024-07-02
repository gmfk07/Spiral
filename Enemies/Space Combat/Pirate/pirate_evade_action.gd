extends EnemyAction

@export var evade := 6

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
