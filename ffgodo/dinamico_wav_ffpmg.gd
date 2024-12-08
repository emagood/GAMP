extends Control

@onready var audio_stream_player = $AudioStreamPlayer
var buffer = PackedByteArray()
var file_path = "res://temp_audio.mp3"
# Función para capturar audio en tiempo real desde un segundo específico
func capture_audio(start_time: int, duration: int) -> void:
	print("Iniciando captura de audio desde %d segundos por %d segundos..." % [start_time, duration])
	var command = "ffmpeg"
	var args = [
		"-ss", str(start_time),  # Tiempo de inicio
		"-i", "input_video.mp4",
		"-t", str(duration),  # Duración
		"-f", "mp3",  # Formato mp3
		"-"
	]

	# Ejecutar FFmpeg y capturar la salida usando execute_with_pipe
	print("Ejecutando FFmpeg...")
	var result = OS.execute_with_pipe(command, args, true)
	if result.keys().size() == 0:
		print("Error al ejecutar FFmpeg para capturar el audio")
		return
	var chunk
	var stdio = result["stdio"]
	while not stdio.eof_reached():
		chunk = stdio.get_buffer(4096)  # Leer en bloques de 4 KB
		if chunk.size() == 0:
			break
		buffer.append_array(chunk)
		#play_music(buffer) 

	# Cerrar el flujo estándar y el proceso de FFmpeg
	play_music(buffer) 
	print("Cerrando flujo estándar de FFmpeg...")
	stdio.close()

# Función para guardar el buffer y reproducir el audio
func save_and_play_audio() -> void:
	# Guardar el buffer en un archivo temporal
	print("Guardando buffer en archivo temporal...")
	var file_path = "res://temp_audio.mp3"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_buffer(buffer)
	file.flush()
	await get_tree().create_timer(0.5).timeout
	file.flush()
	file.close()
	await get_tree().create_timer(0.5).timeout


	## Cargar el archivo de audio desde el buffer y reproducirlo
	#print("Cargando archivo de audio y reproduciendo...")
	#var audio_stream = load(file_path) as AudioStreamWAV
	#if audio_stream:
		#audio_stream_player.stream = audio_stream
		#audio_stream_player.play()
		#print("Reproducción de audio iniciada.")
	#else:
		#print("Error al cargar el archivo WAV")


func play_music(data = null) -> int:
	#if FileAccess.file_exists(file_path):
		#print("Archivo temporal guardado correctamente.")
	#else:
		#print("Error al guardar el archivo temporal.")
		#return 0
	var siz = FileAccess.open(file_path, FileAccess.READ)
	#if siz.get_length() <= 5000:
		#prints( " error de audio ")
		#return 0
		
	# Cargar el archivo de audio desde el buffer y reproducirlo
	print("Cargando archivo de audio y reproduciendo...")
	var loop = true 
	while loop:
		#data = load(file_path)
		if buffer:
			loop = false
			var bytes = data #siz.get_buffer(siz.get_length())
			var stream = AudioStreamMP3.new()
			stream.data = bytes
			audio_stream_player.stream = stream
			audio_stream_player.play()
			prints(audio_stream_player.get_playback_position(), " segundos  " , stream.get_length())
			#stream.play()
			print("Reproducción de audio iniciada.")
		else:
			loop = false
			await get_tree().create_timer(0.5).timeout
			print("Error al cargar el archivo WAV")
	return OK
# Función para capturar y reproducir audio en tiempo real desde un segundo específico
func capture_and_play_audio(start_time: int, duration: int) -> void:
	await capture_audio(start_time, duration)
	#await save_and_play_audio()
	#await play_music()Archivo temporal guardado correctamente.

	#while !audio_stream_player.playing:
		#audio_stream_player.stream = null
		#await get_tree().create_timer(0.5).timeout
		#play_music()
		

# Función ready
func _ready() -> void:
	# Capturar y reproducir audio desde el segundo 3 al 5 (2 segundos de duración)
	capture_and_play_audio(0, 40000)
