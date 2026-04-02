extends Sprite2D

@export var collection_area: Area2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.get_meta("pollen", false):
		collect_pollen(parent)

func collect_pollen(pollen: Node2D):
	pollen.is_being_collected = true
	var tween = create_tween()
	tween.tween_property(pollen, "scale", Vector2(0, 0), .5)
	tween.parallel().tween_property(pollen, "global_position", collection_area.global_position, .5)
	await tween.finished
	pollen.queue_free()
	Global.increment_honey(1)
