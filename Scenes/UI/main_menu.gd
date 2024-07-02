extends Control

const STORY_RUNNER_SCENE := preload("res://scenes/game.tscn")

@onready var continue_button: Button = %Continue

func _ready() -> void:
	get_tree().paused = false

func _on_continue_pressed():
	print ("continue")

func _on_new_run_pressed():
	get_tree().change_scene_to_packed(STORY_RUNNER_SCENE)

func _on_exit_pressed():
	get_tree().quit()
