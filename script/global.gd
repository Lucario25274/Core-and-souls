extends Node

var player_current_attack = false


var current_scene = "world"

#findet wechsel statt?
var transition_scene = false
var player_exit_sideworld_posx = 206.0
var player_exit_sideworld_posy = 22.0

var player_start_posx = 33.0
var player_start_posy = 43.0

# Gibt an, ob das Spiel zum ersten Mal geladen wird
var first_game_loading = true

func finish_changescenes():
		#wenn wechsel aktiv dann wird er hier beendet
		if transition_scene == true:
			transition_scene = false

		#wenn spieler sich in der "world" befindet, wechsle zu "sideworld", sonst zurück zur "world"
		if current_scene == "world":
			current_scene = "sideworld"
		else:
			current_scene = "world"
