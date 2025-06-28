extends Node2D

func _process(_delta):
	change_scene()

# player trifft kollision
func _on_sideworld_exitpoint_body_entered(body):
	if body.has_method("player"):
		# Szenenwechsel aktivieren
		global.transition_scene = true

# player verlässt kollision
func _on_sideworld_exitpoint_body_exited(body):
	if body.has_method("player"):
		# szenenwechsel deaktivieren
		global.transition_scene = false

# szenenwechsel zu world
func change_scene():
	if global.transition_scene == true:
		# prüft, ob spieler aktuell in sideworld ist
		if global.current_scene == "sideworld":
			# Speichert die aktuelle spielerposition
			$player.position.x = global.player_exit_sideworld_posx
			$player.position.y = global.player_exit_sideworld_posy

			# wechselt die Szene zurück in world
			get_tree().change_scene_to_file("res://scenes/world.tscn")

			# Setzt den zustand so das Spiel nicht mehr im erstladevorgang ist
			global.first_game_loading = false
			print("player kommt")

		# aktualisiere neue szene
		global.finish_changescenes()
