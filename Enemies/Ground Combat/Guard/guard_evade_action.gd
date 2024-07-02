extends EnemyAction

@export var amount := 2

func perform_action():
	if not enemy or not target:
		return
	
	var evade_effect = EvadeEffect.new()
	evade_effect.amount = amount
	evade_effect.sound = sound
	evade_effect.execute([enemy])

	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
