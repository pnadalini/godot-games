class_name BlueprintEntity
extends Node

export var placeable := true

onready var _power_direction := find_node("PowerDirection")


func rotate_blueprint() -> void:
	if not _power_direction:
		return

	var directions: int = _power_direction.output_directions
	var new_directions := 0

	if directions & Types.Direction.LEFT != 0:
		new_directions |= Types.Direction.UP

	if directions & Types.Direction.UP != 0:
		new_directions |= Types.Direction.RIGHT

	if directions & Types.Direction.RIGHT != 0:
		new_directions |= Types.Direction.DOWN

	if directions & Types.Direction.DOWN != 0:
		new_directions |= Types.Direction.LEFT

	_power_direction.output_directions = new_directions
