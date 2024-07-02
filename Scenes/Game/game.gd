extends Node

@onready var current_view: Node = $CurrentView
@onready var story: Story = %Story

@export var ground_combat_character: CharacterStats
@export var space_combat_character: CharacterStats

var character: CharacterStats

var enemy_stats_dict = {}

const GROUND_BATTLE_SCENE := preload("res://Scenes/Battle/ground_battle.tscn")
const SPACE_BATTLE_SCENE := preload("res://Scenes/Battle/space_battle.tscn")

func _ready():
	setup_enemy_stats_dict()
	setup_event_connections()

func setup_enemy_stats_dict() -> void:
	enemy_stats_dict["pirate_and_fighter"] = preload("res://Battles/pirate_and_fighter.tres")
	enemy_stats_dict["two_pirates"] = preload("res://Battles/two_pirates.tres")

func return_to_story() -> void:
	clear_current_view()
	story.continue_story()

## Takes in a Battle scene and enemy stats key and starts the battle
func leave_story(battle_scene: PackedScene, enemy_stats_key: String) -> void:
	if not enemy_stats_dict.has(enemy_stats_key):
		return
		
	clear_current_view()
	
	var new_battle := battle_scene.instantiate() as Battle
	new_battle.char_stats = character
	new_battle.battle_stats = enemy_stats_dict[enemy_stats_key]
	current_view.add_child(new_battle)

func handle_battle_won() -> void:
	story.set_story_variable("won_battle", true)
	return_to_story()

func handle_battle_lost() -> void:
	story.set_story_variable("won_battle", false)
	return_to_story()

func setup_event_connections() -> void:
	Events.battle_won.connect(handle_battle_won)
	Events.battle_lost.connect(handle_battle_lost)
	Events.ground_battle_start_requested.connect(start_ground_battle)
	Events.space_battle_start_requested.connect(start_space_battle)

## Removes all children from CurrentView and unpauses.
func clear_current_view() -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	get_tree().paused = false

func start_ground_battle(enemy_stats_key: String) -> void:
	character = ground_combat_character.create_instance()
	leave_story(GROUND_BATTLE_SCENE, enemy_stats_key)

func start_space_battle(enemy_stats_key: String) -> void:
	character = space_combat_character.create_instance()
	leave_story(SPACE_BATTLE_SCENE, enemy_stats_key)
