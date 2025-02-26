class_name EnemyStateMachine extends Node

var states : Array[ EnemyState ]
var previous_state : EnemyState
var current_state : EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var next_state = current_state.Process(delta)
	ChangeState( next_state )

func _physics_process(delta: float) -> void:
	var next_state = current_state.Physics(delta)
	ChangeState( next_state )

func Initialize( _enemy : Enemy ) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append(c)
			c.enemy = _enemy
			c.state_machine = self
			c.Init()
	
	if states.size() > 0:
		ChangeState( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT


func ChangeState( new_state : EnemyState ) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
		
	previous_state = current_state
	current_state = new_state
	current_state.Enter()
