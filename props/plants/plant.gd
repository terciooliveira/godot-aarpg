class_name Plant extends Node2D

@onready var hit_box: HitBox = $HitBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hit_box.Damaged.connect( TakeDamage )
	pass

func TakeDamage( _hurt_box : HurtBox ) -> void:
	animation_player.play("plant-killed")
	animation_player.animation_finished.connect(plant_killed_animation_finished)

func plant_killed_animation_finished( anim : String ) -> void: 
	print("[DEBUG] plan queue free called! " + anim)
	queue_free()
