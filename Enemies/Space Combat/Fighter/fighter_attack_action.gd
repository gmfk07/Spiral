extends EnemyAction

const bullet = preload("res://Scenes/Animations/bullet.tscn")

@export var damage := 4

func perform_action():
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	damage_effect.sound = sound
	
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.position = start
	new_bullet.look_at(end)
	
	tween.tween_property(new_bullet, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_callback(func(): new_bullet.queue_free())

	get_tree().create_timer(0.45, false).timeout.connect(
		func():
			damage_effect = DamageEffect.new()
			damage_effect.amount = damage
			damage_effect.sound = sound
			
			tween = create_tween().set_trans(Tween.TRANS_QUINT)
			
			new_bullet = bullet.instantiate()
			add_child(new_bullet)
			new_bullet.position = start
			new_bullet.look_at(end)
			
			tween.tween_property(new_bullet, "global_position", end, 0.4)
			tween.tween_callback(damage_effect.execute.bind(target_array))
			tween.tween_callback(func(): new_bullet.queue_free())
			
			get_tree().create_timer(0.45, false).timeout.connect(
				func():
					Events.enemy_action_completed.emit(enemy)
			)
	)
