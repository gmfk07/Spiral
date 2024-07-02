class_name Story
extends Node2D

@onready var story_runner: StoryRunner = %StoryRunner

func continue_story():
	story_runner.continue_story()

func set_story_variable(variable_name : String, value):
	story_runner.set_variable(variable_name, value)
