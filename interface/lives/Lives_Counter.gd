extends NinePatchRect

func initialize():
	$Label.text = str(PlayerVars.lives)

func _on_Nuts_Counter_life_Change():
	$Label.text = str(PlayerVars.lives)

func _on_Player2_life_Change():
	$Label.text = str(PlayerVars.lives)
