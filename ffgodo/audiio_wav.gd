extends Control
#
#@onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
#var buffer = PackedByteArray()
#
## Función para capturar y reproducir audio en tiempo real
#func capture_and_play_audio() -> void:
	#print("Iniciando captura de audio...")
	#var command = "ffmpeg"
	#var args = [
		#"-i", "input_video.mp4",
		#"-t", "1",  # Duración de 1 segundo
		#"-f", "wav",  # Formato WAV
		#"-"
	#]
#
	## Ejecutar FFmpeg y capturar la salida usando execute_with_pipe
	#print("Ejecutando FFmpeg...")
	#var result = OS.execute_with_pipe(command, args, true)
	#if result.keys().size() == 0:
		#print("Error al ejecutar FFmpeg para capturar el audio")
		#return
#
	#var stdio = result["stdio"]
	#while not stdio.eof_reached():
		#var chunk = stdio.get_buffer(4096)  # Leer en bloques de 4 KB
		#if chunk.size() == 0:
			#break
		#buffer.append_array(chunk)
		#print("Bytes leídos: ", buffer.size())
#
	## Cerrar el flujo estándar y el proceso de FFmpeg
	#print("Cerrando flujo estándar de FFmpeg...")
	#stdio.close()
#
	## Guardar el buffer en un archivo temporal
	#print("Guardando buffer en archivo temporal...")
	#var file_path = "res://temp_audio.wav"
	#var file = FileAccess.open(file_path, FileAccess.WRITE)
	#file.store_buffer(buffer)
	#file.flush()
	#await get_tree().create_timer(0.5).timeout
	#file.close()
	#await get_tree().create_timer(0.5).timeout
	## Verificar que el archivo se guardó correctamente
	#if FileAccess.file_exists(file_path):
		#print("Archivo temporal guardado correctamente.")
	#else:
		#print("Error al guardar el archivo temporal.")
		#return
#
	## Cargar el archivo de audio desde el buffer y reproducirlo
	#print("Cargando archivo de audio y reproduciendo...")
	#var audio_stream  = load(file_path)
	#if audio_stream:
		#audio_stream_player.stream = audio_stream
		#audio_stream_player.play()
		#print("Reproducción de audio iniciada.")
	#else:
		#print("Error al cargar el archivo WAV")
#
## Función ready
#func _ready() -> void:
	#capture_and_play_audio()
