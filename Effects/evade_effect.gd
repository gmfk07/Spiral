class_name EvadeEffect
extends Effect

var amount := 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		
		if target is Enemy or target is Player:
			target.stats.evade += amount
			SFXPlayer.play(sound)
