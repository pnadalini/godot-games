extends Entity

export var max_storage := 1000.0

var stored_power := 0.0 setget _set_stored_power

onready var receiver := $PowerReceiver
onready var source := $PowerSource
onready var indicator := $Indicator


func _ready() -> void:
	if source.output_direction != 15:
		# ^ works as a XOR, returns 1 if the bits don't match
		receiver.input_direction = 15 ^ source.output_direction


func _set_stored_power(value: float) -> void:
	stored_power = max(value, 0)

	if not is_inside_tree():
		yield(self, "ready")

	receiver.efficiency = (
		0.0
		if stored_power >= max_storage
		else min((max_storage - stored_power) / receiver.power_required, 1.0)
	)

	source.efficiency = (0.0 if stored_power <= 0 else min(stored_power / source.power_amount, 1.0))
	indicator.material.set_shader_param("amount", stored_power / max_storage)


func _on_PowerSource_power_updated(power_draw: float, delta: float) -> void:
	self.stored_power = stored_power - min(power_draw, source.get_effective_power()) * delta


func _on_PowerReceiver_received_power(amount: float, delta: float) -> void:
	self.stored_power = stored_power + amount * delta
