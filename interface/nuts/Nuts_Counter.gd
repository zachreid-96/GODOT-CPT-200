extends NinePatchRect

func initialize():
	pass

signal life_Change()

func _on_Player_nuts_changed():
	getNuts()

func _on_Interface_nuts_updated():
	pass # Replace with function body.

func getNuts():
	PlayerVars.nuts += 1
	if PlayerVars.nuts == 100:
		PlayerVars.nuts = 0
		$Label.text = str(PlayerVars.nuts)
		PlayerVars.lives += 1
		emit_signal("life_Change", PlayerVars.lives)
	else:
		$Label.text = str(PlayerVars.nuts)
