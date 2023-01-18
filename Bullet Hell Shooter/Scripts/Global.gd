extends Node

var node_creation_parent = null

var player = null
var camera = null

var score = 0
var highScore = 0

var sound_controller = null

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func play_sound(sound):
	if sound_controller:
		#Checks if node exists under sound controller
		if sound_controller.has_node(sound):
			#If so, we get the node and play the sound
			sound_controller.get_node(sound).play()
	pass
