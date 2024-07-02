class_name TextEntry
extends PanelContainer

@onready var prompt: RichTextLabel = %Prompt
@onready var line_edit: LineEdit = %LineEdit
@onready var submit_button: Button = %Submit

func initialize(prompt_string : String) -> void:
	prompt.text = prompt_string

func _on_line_edit_text_changed(new_text):
	var is_text_empty = new_text.strip_edges().is_empty()
	submit_button.disabled = is_text_empty

func _on_submit_pressed():
	Events.text_entry_submitted.emit(self)
