extends BattleCard

func apply_effects(targets: Array[Node]) -> void:
	var evade_effect := EvadeEffect.new()
	evade_effect.amount = 6
	evade_effect.sound = sound
	evade_effect.execute(targets)
