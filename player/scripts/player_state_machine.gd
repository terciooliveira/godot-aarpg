class_name PlayerStateMachine extends Node

var states : Array[ State ]
var previous_state : State
var current_state : State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _process(delta: float) -> void:
	var next_state = current_state.Process(delta)
	ChangeState( next_state )

func _physics_process(delta: float) -> void:
	var next_state = current_state.Physics(delta)
	ChangeState( next_state )
	
func _unhandled_input(event: InputEvent) -> void:
	var next_state = current_state.HandleInput( event )
	ChangeState( next_state )
	
func Initialize( _player : Player ) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
			
	if states.size() == 0:
		return
	
	states[0].player = _player
	states[0].state_machine = self
	
	for state in states:
		state.init()
		
	ChangeState( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState( new_state : State ) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
		
	previous_state = current_state
	current_state = new_state
	current_state.Enter()
	
	
