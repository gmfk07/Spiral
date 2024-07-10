extends Node2D

@export var persuasion_stats: PersuasionStats
@export var music: AudioStream

@onready var persuasion_ui: PersuasionUI = $PersuasionUI as PersuasionUI
@onready var player_handler: PlayerPersuasionHandler = $PlayerPersuasionHandler as PlayerPersuasionHandler

func _ready() -> void:
	start_battle()
	persuasion_ui.initialize_card_pile_ui()

func start_battle() -> void:
	get_tree().paused = false
	MusicPlayer.play(music, true)
	persuasion_stats = persuasion_stats.create_instance()
	
	player_handler.start_persuasion(persuasion_stats)
	
	persuasion_ui.persuasion_stats = persuasion_stats
	
	persuasion_ui.initialize_card_pile_ui()


func _on_discard_button_pressed():
	player_handler.discard_selected_cards()
	get_tree().create_timer(0.2, false).timeout.connect(player_handler.draw_cards)
