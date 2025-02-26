class_name StateAttack extends State

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0

@onready var idle: StateIdle = $"../Idle"
@onready var walk: StateWalk = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_effect: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

var attacking : bool = false
	
# what happens when player enters this state
func Enter() -> void:
	var anim : String = player.UpdateAnimation("attack")
	animation_effect.play(anim);
	animation_player.animation_finished.connect( EndAttack )
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	
	await get_tree().create_timer( 0.075 ).timeout
	hurt_box.monitoring = true

func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	hurt_box.monitoring = false
	pass

func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction != Vector2.ZERO:
			return walk
		else:
			return idle
	
	return null
	
func Physics( _delta : float ) -> State:
	return null	
	
func HandleInput( _event : InputEvent ) -> State:
	return null

func EndAttack( _newAnimName : String ) -> bool:
	attacking = false
	return attacking
	
	
