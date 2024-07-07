class_name StatsUI
extends HBoxContainer

@onready var evade: HBoxContainer = $Evade
@onready var evade_label: Label = %EvadeLabel
@onready var health: HBoxContainer = $Health
@onready var health_label: Label = %HealthLabel

func update_stats(stats: BattleStats) -> void:
	evade_label.text = str(stats.evade)
	health_label.text = str(stats.health)

	evade.visible = stats.evade > 0
	health.visible = stats.health > 0
