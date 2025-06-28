class_name EnemyRunState
extends State

var own: LittleBlack

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	own = owner_node

func enter() -> void:
	own.animation_player.play("run")
	
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	own.velocity.x = own.direction * E_RUN_SPEED
	
func update(delta: float) -> void:

	if state_machine.current_state_delay > 1:
		state_machine.change_to(own.enemy_walk_state)

func process_input(event: InputEvent) -> void:
	pass
