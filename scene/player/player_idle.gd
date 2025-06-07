class_name PlayerIdleState
extends State

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine

func enter() -> void:
	owner_node.animation_player.play("idle")
	owner_node.velocity.x = 0
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	# 输入处理优先级
	if Input.is_action_just_pressed("attack"):
		state_machine.change_to(owner_node.player_attack_state)
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		state_machine.change_to(owner_node.player_walk_state)
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(owner_node.player_jump_state)
		
	
	

		
func update(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass
