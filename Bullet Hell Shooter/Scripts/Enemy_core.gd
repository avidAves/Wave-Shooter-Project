extends Sprite

export(int) var speed = 100

var velocity = Vector2()

var stun = false

export(int) var knockback = 600

export(int) var hp = 3

export(int) var screen_shake = 80

export(String) var base_color = "ffffff"

export(String) var damage_color = "ff4944"

func _process(_delta):
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(screen_shake,0.2)
		Global.play_sound("enemyDeath")
		Global.score += 100
		queue_free()

func basic_movement_towards_player(delta):
	if Global.player != null and stun != true:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
		global_position += velocity * delta
	
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_Damager"):
		hp -= 1
		modulate = Color(damage_color)
		velocity = -velocity * knockback
		stun = true
		$Stun_timer.start()
		area.get_parent().queue_free()
	pass

func _on_Stun_timer_timeout():
	modulate = Color(base_color)
	stun = false
