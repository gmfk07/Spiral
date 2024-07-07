class_name BattleCardUI
extends CardUI

signal reparent_requested(which_card_ui: BattleCardUI)

const BASE_STYLEBOX := preload("res://Scenes/Card UI/card_base_style_box.tres")
const DRAG_STYLEBOX := preload("res://Scenes/Card UI/card_dragging_stylebox.tres")
const HOVER_STYLEBOX := preload("res://Scenes/Card UI/card_hover_style_box.tres")

@export var battle_card: BattleCard : set = _set_card
@export var char_stats: CharacterStats : set = _set_char_stats

@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon
@onready var drop_point_detector: Area2D = $DropPointDetector

@onready var targets: Array[Node] = []

var original_index := 0
var playable := true : set = _set_playable
var disabled := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_state_machine = $CardStateMachine as CardStateMachine
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func play() -> void:
	if not battle_card:
		return
	
	battle_card.play(targets, char_stats)
	queue_free()

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _set_card(value: BattleCard) -> void:
	if not is_node_ready():
		await ready

	battle_card = value
	cost.text = str(battle_card.cost)
	icon.texture = battle_card.icon

func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1, 1, 1, 0.5)
	else:
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1, 1, 1, 1)
		
func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	char_stats.stats_changed.connect(_on_char_stats_changed)

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)

func _on_card_drag_or_aiming_started(used_card: BattleCardUI) -> void:
	if used_card == self:
		return
	
	disabled = true

func _on_card_drag_or_aiming_ended(_card: BattleCardUI) -> void:
	disabled = false
	self.playable = char_stats.can_play_battle_card(battle_card)

func _on_char_stats_changed() -> void:
	self.playable = char_stats.can_play_battle_card(battle_card)
