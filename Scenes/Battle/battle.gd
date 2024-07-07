class_name Battle
extends Node2D

@export var enemy_encounter_stats: EnemyEncounterStats
@export var char_stats: CharacterStats
@export var music: AudioStream

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerCharacterHandler = $PlayerCharacterHandler as PlayerCharacterHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player = $Player as Player

func _ready() -> void:
	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	
	start_battle()
	battle_ui.initialize_card_pile_ui()
	
func start_battle() -> void:
	get_tree().paused = false
	MusicPlayer.play(music, true)
	char_stats = char_stats.create_instance()
	
	player_handler.start_battle(char_stats)
	
	battle_ui.char_stats = char_stats
	player.stats = char_stats
	
	enemy_handler.setup_enemies(enemy_encounter_stats)
	enemy_handler.reset_enemy_actions()
	
	battle_ui.initialize_card_pile_ui()

func _on_enemies_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		Events.battle_over_screen_requested.emit("Victory", BattleOverPanel.Type.WIN)

func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_player_died() -> void:
	Events.battle_over_screen_requested.emit("Game Over", BattleOverPanel.Type.LOSE)
