class_name PlayerFallState
extends State

const MAX_FALL_SPEED = 600


func enter() -> void:
	owner_node.animation_player.play("fall")
	
func physics_update(delta: float) -> void:
	owner_node.velocity.y = min(MAX_FALL_SPEED, owner_node.velocity.y+(delta*gravity))
	if owner_node.is_on_floor() and tend_to_move():
		state_machine.change_to(owner_node.player_walk_state)
	elif  owner_node.is_on_floor():
		state_machine.change_to(owner_node.player_idle_state)
