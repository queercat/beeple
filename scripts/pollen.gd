extends Sprite2D

@export var area2d: Area2D
@export var spawn_threshold: = 40
var is_hovered: bool
var is_grabbed: bool
var is_growing: bool
var is_being_collected: bool
var spawn = null

func _ready() -> void:
	pass

func grow():
	is_growing = true
	var tween = create_tween()
	var s = randf_range(-.05, .05) + scale.x
	scale = Vector2(0, 0)
	tween.tween_property(self, "scale", Vector2(s, s), Global.seconds_to_grow)
	await tween.finished
	is_growing = false

func _process(delta: float) -> void:
	if is_growing: return
	if is_being_collected: return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if is_hovered:
			is_grabbed = true
	else: is_grabbed = false
	
	if is_grabbed:
		position = lerp(position, get_viewport().get_mouse_position(), .1)
		if spawn and position.distance_to(spawn.position) > spawn_threshold:
			spawn.is_occupied = false
			spawn = null

func _draw() -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
