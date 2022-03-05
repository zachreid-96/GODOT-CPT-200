extends NinePatchRect

func initialize():
	pass

func _on_Collectable_nuts_changed(nuts):
	$Label.text = str(int($Label.text) + nuts)

func _on_Collectable2_nuts_changed(nuts):
	$Label.text = str(int($Label.text) + nuts)


func _on_Interface_nuts_updated(count):
	pass # Replace with function body.
