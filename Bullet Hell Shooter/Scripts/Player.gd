extends Sprite


var speed = 150
var velocity = Vector2()
export (float) var defaultShotRate = 0.5

var canShoot = true
var canCharge = true
var isDead = false
var attackCoin = preload("res://Scenes/attackCoin.tscn")

func _ready():
	$Timers/Reload_speed.wait_time = defaultShotRate
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if isDead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and canShoot == true and isDead == false:
		Global.play_sound("shoot")
		Global.instance_node(attackCoin, global_position, Global.node_creation_parent)
		$Timers/Reload_speed.start()
		canShoot = false
	
	if Input.is_action_pressed("overcharge") and canCharge == true:
		$Timers/Reload_speed.wait_time = 0.05
		$Timers/Overcharge_limit.start()
		pass

#A shit-ton of timers
func _on_Reload_speed_timeout():
	canShoot = true


func _on_Overcharge_recharge_timeout():
	canCharge = true


func _on_Overcharge_limit_timeout():
	$Timers/Reload_speed.wait_time = defaultShotRate
	canCharge = false
	$Timers/Overcharge_recharge.start()


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		isDead = true
		visible = false
		yield(get_tree().create_timer(1),"timeout")
		if Global.score > Global.highScore:
			Global.highScore = Global.score
		Global.score = 0
		get_tree().reload_current_scene()
