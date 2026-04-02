extends Node

var honey = 0
var honey_per_second = .5
var seconds_to_grow = 1

signal honey_updated(old, new)

func deincrement_honey(how_much):
	var old = honey
	honey -= how_much
	honey_updated.emit(old, honey)

func increment_honey(how_much):
	var old = honey
	honey += how_much
	honey_updated.emit(old, honey)
