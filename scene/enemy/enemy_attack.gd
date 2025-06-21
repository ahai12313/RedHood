class_name EnemyAttackState
extends State

var own: LittleBlack

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	own = owner_node

func enter() -> void:
	own.animation_player.play("attack")
	own.velocity.x = 0
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
	
func update(delta: float) -> void:
	if not own.animation_player.is_playing():
		state_machine.change_to(own.enemy_idle_state)

func process_input(event: InputEvent) -> void:
	pass
