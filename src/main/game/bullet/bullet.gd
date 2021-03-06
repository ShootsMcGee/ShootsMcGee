"""
Handles interactions with a bullet after it is fired.

Author: Srayan Jana
"""


extends KinematicBody2D


export var bullet_speed: float = 500
export var bullet_damage: float = 1
export var life_span: float = 60 # In seconds.
var bullet_direction: Vector2 = Vector2(1, 0)

var _player_owner


func _physics_process(delta: float) -> void:
	"""
	Called every frame and moves the bullet every frame. Destroys the bullet
	if it's been alive for too long.

	delta: The amount of time since the last frame.
	"""

	life_span -= delta

	if life_span > 0:
		move_and_slide(bullet_speed * bullet_direction)
	else:
		queue_free()


func _on_hit(hit_object: Node) -> void:
	"""
	Called when the bullet hits an object. Destroys the bullet and
	damages a player if one was hit.
	"""

	if hit_object != _player_owner:
		queue_free()

		if hit_object.has_method('get_team') and hit_object.get_team() == _player_owner.get_team(): # If the target is the same team as player
			return
		
		if hit_object.is_in_group("Hittable"):
			hit_object.on_hit(bullet_damage, _player_owner)
