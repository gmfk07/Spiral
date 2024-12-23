extends Node2D

@export var persuasion_stats: PersuasionStats
@export var music: AudioStream

@onready var persuasion_ui: PersuasionUI = $PersuasionUI as PersuasionUI
@onready var player_handler: PlayerPersuasionHandler = $PlayerPersuasionHandler as PlayerPersuasionHandler
@onready var enemy_handler: EnemyPersuasionHandler = $EnemyPersuasionHandler as EnemyPersuasionHandler

enum PersuasionActions { CHECK, CALL, BET, RAISE, FOLD }

var blind := 1
var pot := 0: set = _set_pot
var bet := 0
var player_initiative := true

func _ready() -> void:
	start_persuasion()

func start_persuasion() -> void:
	get_tree().paused = false
	MusicPlayer.play(music, true)
	persuasion_stats = persuasion_stats.create_instance()
	
	player_handler.start_persuasion(persuasion_stats)
	persuasion_ui.persuasion_stats = persuasion_stats
	persuasion_ui.initialize_card_pile_ui()
	
	persuasion_ui.bet_widget_ui.bet_changed.connect(bet_changed)
	persuasion_ui.set_bet_widget_ui_visibility(false)
	
	Events.player_bet_confirmed.connect(bet_confirmed)

	handle_hand_start()

func handle_hand_start() -> void:
	change_player_chip_count(-blind)
	change_enemy_chip_count(-blind)
	pot += blind * 2

func _on_discard_button_pressed():
	persuasion_ui.continue_to_bet()
	if player_handler.hand.selected_card_ui_array.size() == 0:
		Events.player_hand_drawn.emit()
	else:
		player_handler.discard_selected_cards()
		get_tree().create_timer(0.2, false).timeout.connect(draw_cards)

func draw_cards():
	player_handler.draw_cards()

func change_player_chip_count(delta: int) -> void:
	player_handler.change_chip_count(delta)
	persuasion_ui.update_player_chips_label(player_handler.chips)

func change_enemy_chip_count(delta: int) -> void:
	enemy_handler.change_chip_count(delta)
	persuasion_ui.update_enemy_chips_label(enemy_handler.chips)

func _set_pot(value: int) -> void:
	pot = value
	persuasion_ui.update_pot_label(value)

func bet_changed(value: int) -> void:
	bet = value

func bet_confirmed() -> void:
	if bet > 0:
		change_player_chip_count(-bet);
		pot += bet
		enemy_handler.respond_to_player_bet(bet, pot)

func _on_player_turn_ended() -> void:
	pass
