class_name PlayerJumpState
extends State

const JUMP_SPEED = -600

func enter() -> void:
	owner_node.animation_player.play("jump")
	owner_node.velocity.y = JUMP_SPEED
	owner_node.move_and_slide()
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	owner_node.velocity.y += gravity * delta
	if not owner_node.is_on_floor() and owner_node.velocity.y >= 0:
		state_machine.change_to(owner_node.player_fall_state)
	
	
func update(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass
