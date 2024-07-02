extends BattleCard

func apply_effects(targets: Array[Node]):
	var evade_effect := EvadeEffect.new()
	evade_effect.amount = 2
	evade_effect.sound = sound
	evade_effect.execute(targets)
