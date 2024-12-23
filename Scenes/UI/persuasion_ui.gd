class_name PersuasionUI
extends CanvasLayer

@export var persuasion_stats: PersuasionStats : set = _set_persuasion_stats
@export var discard_button_discard_text: String = "Discard"
@export var discard_button_keep_text: String = "Keep"

@onready var hand: Hand = $Hand as Hand
@onready var draw_pile_button: CardPileOpener = %DrawPileButton
@onready var discard_pile_button: CardPileOpener = %DiscardPileButton
@onready var draw_pile_view: CardPileView = %DrawPileView
@onready var discard_pile_view: CardPileView = %DiscardPileView
@onready var discard_button: Button = %DiscardButton
@onready var confirm_button: Button = %ConfirmButton
@onready var pot_label: Label = %PotLabel
@onready var player_chips_label: Label = %PlayerChipsLabel
@onready var enemy_chips_label: Label = %EnemyChipsLabel
@onready var bet_widget_ui: BetWidgetUI = $BetWidgetUI as BetWidgetUI

func _ready() -> void:
	confirm_button.disabled = true
	discard_button.disabled = true
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	draw_pile_button.pressed.connect(draw_pile_view.show_current_view.bind("Draw Pile", true))
	discard_pile_button.pressed.connect(discard_pile_view.show_current_view.bind("Discard Pile"))
	discard_button.text = discard_button_discard_text
	bet_widget_ui.visible = false

func _process(delta):
	if hand.selected_card_ui_array.size() == 0:
		discard_button.text = discard_button_keep_text
	else:
		discard_button.text = discard_button_discard_text

func initialize_card_pile_ui() -> void:
	draw_pile_button.card_pile = persuasion_stats.draw_pile
	draw_pile_view.card_pile = persuasion_stats.draw_pile
	discard_pile_button.card_pile = persuasion_stats.discard
	discard_pile_view.card_pile = persuasion_stats.discard

func update_pot_label(pot: int) -> void:
	pot_label.text = "Pot: " + str(pot)
	
func update_player_chips_label(chips: int) -> void:
	player_chips_label.text = "You: " + str(chips)

func update_enemy_chips_label(chips: int) -> void:
	enemy_chips_label.text = "Enemy: " + str(chips)

func set_bet_widget_ui_visibility(value: bool) -> void:
	bet_widget_ui.visible = value

func continue_to_bet() -> void:
	discard_button.visible = false
	confirm_button.visible = true
	confirm_button.disabled = true
	bet_widget_ui.visible = true

func _set_persuasion_stats(value: PersuasionStats) -> void:
	persuasion_stats = value
	hand.persuasion_stats = persuasion_stats

func _on_confirm_button_pressed():
	discard_button.visible = false
	confirm_button.visible = false
	bet_widget_ui.visible = false
	Events.player_bet_confirmed.emit()

func _on_player_hand_drawn():
	confirm_button.disabled = false
	discard_button.disabled = false
