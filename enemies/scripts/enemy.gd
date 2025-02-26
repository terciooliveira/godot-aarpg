class_name Enemy extends CharacterBody2D

signal DirectionChanged( new_direction : Vector2 )
signal enemy_damaged( hurt_box : HurtBox )
signal enemy_destroyed( hurt_box : HurtBox )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var changed_direction : bool = false
var player : Player
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var enemy_state_machine : EnemyStateMachine = $EnemyStateMachine
@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_state_machine.Initialize( self )
	player = PlayerManager.player
	hit_box.Damaged.connect( _take_damage )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func _SetDirection( new_direction : Vector2 ) -> bool:
	direction = new_direction
	
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round(
		( direction + cardinal_direction * 0.1 ).angle()
		/ TAU * DIR_4.size()
	))
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	DirectionChanged.emit( new_dir )
	
	return true
	
	
func UpdateAnimation( state : String ) -> String:
	var anim : String = state + "_" + AnimDirection()
	animation_player.play( anim )
	return anim
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func HasChangedDirection() -> bool:
	return changed_direction

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit( hurt_box )
	else:
		enemy_destroyed.emit( hurt_box )
	pass
