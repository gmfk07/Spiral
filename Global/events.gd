extends Node

#Card-related events
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: BattleCard)
signal card_tooltip_requested(card: BattleCard)
signal tooltip_hide_requested

#Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
signal player_hit
signal player_died

#Enemy-related events
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended

#Battle-related events
signal ground_battle_start_requested(enemy_stats_key: String)
signal space_battle_start_requested(enemy_stats_key: String)
signal battle_over_screen_requested(text: String, type: BattleOverPanel.Type)
signal battle_won
signal battle_lost

#Story-related events
signal text_entry_submitted(text_entry: TextEntry)
