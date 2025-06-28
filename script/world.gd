extends Node2D

#start ausführung
func _ready():
	# überprüft ob das Spiel zum ersten mal geladen wird
	if global.first_game_loading == true:
		# Setzt die Startposition des Spielers auf die definierte Startposition
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		#spielerposition = rückkehrposition
		$player.position.x = global.player_exit_sideworld_posx
		$player.position.y = global.player_exit_sideworld_posy

func _process(_delta):
	change_scene()

# wenn player kollision trifft
func _on_sideworld_transitionpoint_body_entered(body):
	# überprüfung obs der player is
	if body.has_method("player"):
		# ja = szenenwechsel aktiviert
		global.transition_scene = true

# wenn player kollision verlässt
func _on_sideworld_transitionpoint_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	# prüft Szenenwechsel aktiv ist
	if global.transition_scene == true:
		# Prüft, ob spieler aktuell in "world" ist
		if global.current_scene == "world":
			# wechselt szene
			get_tree().change_scene_to_file("res://scenes/sideworld.tscn")

			# spiel ist nicht mehr im ersten ladezustand
			global.first_game_loading = false


			print("player geht")

		# aktualisiere neue szene
		global.finish_changescenes()
