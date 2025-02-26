class_name Plant extends Node2D

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect( TakeDamage )
	pass

func TakeDamage( _hurt_box : HurtBox ) -> void:
	queue_free()
