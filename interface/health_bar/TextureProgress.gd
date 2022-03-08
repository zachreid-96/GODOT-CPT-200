extends TextureProgress

func _on_Health_Bar_maximum_changed():
	self.value = PlayerVars.health
