extends TextureProgress

func _on_Health_Bar_maximum_changed(health):
	self.value = health
