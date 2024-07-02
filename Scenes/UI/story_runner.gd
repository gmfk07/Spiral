class_name StoryRunner
extends VBoxContainer

@export var story: InkStory

const text_entry = preload("res://Scenes/UI/text_entry.tscn")

var text_entry_variable_name: String = ""

func _ready() -> void:
	Events.text_entry_submitted.connect(handle_submit)
	observe_variables()
	continue_story()

func continue_story() -> void:
	for child in get_children():
		child.queue_free()
	
	while (story.GetCanContinue()):
		var label = Label.new()
		var text = story.Continue()
		
		## An @ means we need to stop
		if text.contains("@"):
			break
		
		## A $ means we need to stop and enter some type of battle
		if text.contains("$"):
			var enemy_stats_key = story.FetchVariable("enemy_stats_key")
			if text.contains("space"):
				Events.space_battle_start_requested.emit(enemy_stats_key)
			elif text.contains("ground"):
				Events.ground_battle_start_requested.emit(enemy_stats_key)
			break
		
		label.text = text
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		add_child(label)
		
		for choice in story.GetCurrentChoices():
			var button = Button.new()
			button.text = choice.Text
			
			button.pressed.connect(
				func():
					story.ChooseChoiceIndex(choice.Index)
					continue_story()
			)
		
			add_child(button)

func observe_variables() -> void:
	story.ObserveVariable("prompt_variable_name", initiate_text_entry)

func set_variable(variable_name : String, value) -> void:
	story.StoreVariable(variable_name, value)

func initiate_text_entry(variable_name, new_value):
	var prompt = story.FetchVariable("prompt")
	var new_text_entry = text_entry.instantiate()
	
	add_child(new_text_entry)
	new_text_entry.prompt.text = prompt
	
	text_entry_variable_name = new_value

func handle_submit(submitted_text_entry):
	story.StoreVariable(text_entry_variable_name, submitted_text_entry.line_edit.text)
	continue_story()
