class_name PlayerRunState
extends State

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine

func enter() -> void:
	owner_node.animation_player.play("run")
	owner_node.velocity.x = RUN_SPEED
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
		
func update(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass
