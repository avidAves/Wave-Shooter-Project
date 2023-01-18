extends Label

func _process(delta):
	text = "High Score:" + String(Global.highScore)
