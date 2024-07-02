# meta-name: Card Logic
# meta-description: What happens when a card is played.
extends BattleCard

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node]) -> void:
	print("Card played")
	print("Targets: %s" % targets)
