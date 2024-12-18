extends ColorRect

#Save this for a class Animation

@export var VU_COUNT: int = 30
@export var FREQ_MAX: float = 11050.0
@export var MIN_DB: float = 60
@export var ANIMATION_SPEED: float = 0.1
@export var HEIGHT_SCALE: float = 8.0

var spectrum: AudioEffectSpectrumAnalyzerInstance
var min_values: PackedFloat32Array = []
var max_values: PackedFloat32Array = []
var timer = 50
var timer_count = 0


func _ready() -> void:
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	min_values.resize(VU_COUNT)
	min_values.fill(0.0)
	max_values.resize(VU_COUNT)
	max_values.fill(0.0)


func _process(_delta: float) -> void:

	'''  20 HZ  timer = 50 micro sec '''



	timer_count = Time.get_ticks_msec()
	if timer_count >= timer:
		timer += 50

		var prev_hz: float = 0
		var data: PackedFloat32Array = []
		for i: int in range(1, VU_COUNT + 1):
			var hz: float = i * FREQ_MAX / VU_COUNT
			var f: Vector2 = spectrum.get_magnitude_for_frequency_range(prev_hz, hz)
			var energy: float = clamp((MIN_DB + linear_to_db(f.length())) / MIN_DB, 0.0, 1.0)
			data.append(energy * HEIGHT_SCALE)
			prev_hz = hz
		for i: int in range(VU_COUNT):
			if data[i] > max_values[i]:
				max_values[i] = data[i]
			else:
				max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)
			if data[i] <= 0.0:
				min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)
		var fft: PackedFloat32Array = []
		for i: int in range(VU_COUNT):
			fft.append(lerp(min_values[i], max_values[i], ANIMATION_SPEED))
		get_material().set_shader_parameter("freq_data", fft)
		pass


func _on_loal_pressed() -> void:
	prints("stac")
	pass # Replace with function body.
