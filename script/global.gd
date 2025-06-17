extends Node

var player_current_attack = false

var current_scene = "world"
var transition_scene = false

var player_exit_sideworld_posx = 206.0
var player_exit_sideworld_posy = 22.0
var player_start_posx = 33.0
var player_start_posy = 43.0

var first_game_loading = true



func finish_changescenes():
		if transition_scene == true:
			transition_scene = false
		if current_scene == "world":
			current_scene = "sideworld"
		else:
			current_scene = "world"
