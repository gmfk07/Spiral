class_name PersuasionUI
extends CanvasLayer

@export var persuasion_stats: PersuasionStats : set = _set_persuasion_stats

@onready var hand: Hand = $Hand as Hand
@onready var draw_pile_button: CardPileOpener = %DrawPileButton
@onready var discard_pile_button: CardPileOpener = %DiscardPileButton
@onready var draw_pile_view: CardPileView = %DrawPileView
@onready var discard_pile_view: CardPileView = %DiscardPileView
@onready var discard_button: Button = %DiscardButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	draw_pile_button.pressed.connect(draw_pile_view.show_current_view.bind("Draw Pile", true))
	discard_pile_button.pressed.connect(discard_pile_view.show_current_view.bind("Discard Pile"))
	discard_button.disabled = true

func _process(delta):
	discard_button.disabled = hand.selected_card_ui_array.size() == 0

func initialize_card_pile_ui() -> void:
	draw_pile_button.card_pile = persuasion_stats.draw_pile
	draw_pile_view.card_pile = persuasion_stats.draw_pile
	discard_pile_button.card_pile = persuasion_stats.discard
	discard_pile_view.card_pile = persuasion_stats.discard

func _set_persuasion_stats(value: PersuasionStats) -> void:
	persuasion_stats = value
	hand.persuasion_stats = persuasion_stats

func _on_player_hand_drawn() -> void:
	# end_turn_button.disabled = false
	pass

func _on_end_turn_button_pressed() -> void:
	# end_turn_button.disabled = true
	Events.player_turn_ended.emit()
