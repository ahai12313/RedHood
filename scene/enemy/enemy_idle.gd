class_name EnemyIdleState
extends State

var own: LittleBlack

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	own = owner_node

func enter() -> void:
	own.animation_player.play("idle")
	own.velocity.x = 0
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	if own.is_beside_platform():
		own.turn_around()
	
func update(delta: float) -> void:
	
	if own.discovered_player():
		state_machine.change_to(own.enemy_run_state)
		return
	
	if state_machine.current_state_delay > 2:
		state_machine.change_to(own.enemy_walk_state)
		return

func process_input(event: InputEvent) -> void:
	pass
