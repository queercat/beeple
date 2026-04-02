extends Control

@export var honey_label: Label

func _ready():
	Global.honey_updated.connect(honey_updated)

func _process(delta: float) -> void:
	pass

func honey_updated(old, new):
	honey_label.text = "Honey: %d" % new
