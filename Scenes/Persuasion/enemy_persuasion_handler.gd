class_name EnemyPersuasionHandler
extends Node

var chips: int = 15

func start_persuasion(given_stats: PersuasionStats):
	chips = given_stats.chips
	
func respond_to_player_bet(bet: int, pot: int):
	pass

#Changes the amount of chips by delta. Returns true if all in and false otherwise
func change_chip_count(delta: int):
	chips += delta
