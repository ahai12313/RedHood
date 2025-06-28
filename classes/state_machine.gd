class_name StateMachine
extends Node

var current_state: State = null
var current_state_delay: float

func init(state: State) -> void:
	pass
	
func change_to(state: State):
	#print("[FSM] %s => %s" % [current_state, state])
	if state == current_state:
		return
	
	current_state_delay = 0.0
	
	if current_state:
		current_state.exit()
	current_state = state
	current_state.enter()
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		current_state_delay += delta
		
func _input(event: InputEvent) -> void:
	if current_state:
		current_state.process_input(event)
