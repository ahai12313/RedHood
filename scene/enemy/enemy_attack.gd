class_name EnemyAttackState
extends State

var own: LittleBlack

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	own = owner_node

func enter() -> void:
	_attack()
	
	own.velocity.x = 0
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	if own.animation_player.is_playing():
		return
	var overlapping_areas = own.enemy_body.get_overlapping_areas()
	if not overlapping_areas:
		if own.player_detect.is_colliding():
			state_machine.change_to(own.enemy_run_state)
		else:
			state_machine.change_to(own.enemy_idle_state)
	else:
		_attack()
	#for area in overlapping_areas:
		#state_machine.change_to(enemy_attack_state)
	
func update(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass

func _attack() -> void:
	if own.enemy_type == "boxer":
		own.animation_player.play("box")
	else:
		own.animation_player.play("attack")
