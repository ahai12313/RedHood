class_name PlayerWalkState
extends State

func enter() -> void:
	owner_node.animation_player.play("walk")

func physics_update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction == 1.0:
		owner_node.direction = owner_node.Direction.RIGHT
	elif direction == -1.0:
		owner_node.direction = owner_node.Direction.LEFT
	owner_node.velocity.x = direction * WALK_SPEED
	if Input.is_action_just_pressed("attack"):
		state_machine.change_to(owner_node.player_attack_state)
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(owner_node.player_jump_state)
	
	if owner_node.velocity.x == 0 and not tend_to_move():
		state_machine.change_to(owner_node.player_idle_state)

func process_input(event: InputEvent) -> void:
	#if event.is_action_pressed("jump"):
		#state_machine.change_to(owner_node.player_jump_state)
	pass
