class_name EnemyWalkState
extends State

var own: LittleBlack

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	own = owner_node

func enter() -> void:
	own.animation_player.play("walk")
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	own.velocity.x = own.direction * E_WALK_SPEED
	
func update(delta: float) -> void:
	if own.discovered_player():
		state_machine.change_to(own.enemy_run_state)
		return
	
	if state_machine.current_state_delay > 10:
		state_machine.change_to(own.enemy_idle_state)

func process_input(event: InputEvent) -> void:
	pass

func turn_around():
	own.direction *= -1
