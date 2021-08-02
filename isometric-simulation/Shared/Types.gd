class_name Types
extends Reference

# The directions are in binary to combine them like UP & RIGHT -> 0b1001
enum Direction { RIGHT = 0b0001, DOWN = 0b0010, LEFT = 0b0100, UP = 0b1000 }

const NEIGHBORS := {
	Direction.RIGHT: Vector2.RIGHT,
	Direction.DOWN: Vector2.DOWN,
	Direction.LEFT: Vector2.LEFT,
	Direction.UP: Vector2.UP,
}

const POWER_MOVERS := "power_movers"
const POWER_RECEIVERS := "power_receivers"
const POWER_SOURCES := "power_sources"
