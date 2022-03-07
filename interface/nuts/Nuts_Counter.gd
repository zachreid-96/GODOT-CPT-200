extends NinePatchRect

func initialize():
	pass

signal life_Change(lives)

func _on_Player2_nuts_changed(nuts):
	getNuts(nuts)

func _on_Interface_nuts_updated(count):
	pass # Replace with function body.

func getNuts(nuts):
	PlayerVars.nuts += nuts
	if PlayerVars.nuts == 100:
		PlayerVars.nuts = 0
		$Label.text = str(PlayerVars.nuts)
		PlayerVars.lives += 1
		emit_signal("life_Change", PlayerVars.lives)
	else:
		$Label.text = str(PlayerVars.nuts)
