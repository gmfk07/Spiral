# meta-name: EnemyAction
# meta-description: An action which can be performed by an enemy during its turn.
extends EnemyAction

const bullet = preload("res://Scenes/Animations/bullet.tscn")

func perform_action() -> void:
	if not enemy or not target:
		return
