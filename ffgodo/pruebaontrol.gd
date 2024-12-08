extends Control

#@onready var texture_rect = $TextureRect
#var frame_count = 0
#
## Función para iniciar el proceso FFmpeg y manejar la salida
#func start_ffmpeg():
	## Ejecutar el comando FFmpeg para capturar el primer frame
	#await run_ffmpeg(0)
#
## Función para ejecutar FFmpeg
#func run_ffmpeg(frame_number: int) -> void:
	#var command = "ffmpeg"
	#var args = [
		#"-i", "input_video.mp4",
		#"-vf", "select=eq(n\\," + str(frame_number) + ")",  # Capturar un frame específico
		#"-vframes", "1",  # Capturar solo un frame
		#"-f", "image2pipe",
		#"-vcodec", "png",
		#"-"
	#]
#
	## Ejecutar FFmpeg y capturar la salida usando execute_with_pipe
	#var result = OS.execute_with_pipe(command, args, true)
	#if result.keys().size() == 0:
		#print("Error al ejecutar FFmpeg")
		#return
#
	#var stdio = result["stdio"]
	#var buffer = PackedByteArray()
#
	#while not stdio.eof_reached():
		#var chunk = stdio.get_buffer(32768
#)  # Leer en bloques de 8 KB
		#if chunk.size() == 0:
			#break
#
		#buffer.append_array(chunk)
		#print("Bytes leídos: ", buffer.size())
#
	## Intentar cargar la imagen desde el buffer completo
	#var err = process_frame(buffer)
	#if err == OK:
		#print("Frame procesado correctamente")
		#frame_count += 1
		#if frame_count < 12:
			#await get_tree().create_timer(0.01).timeout
			#await run_ffmpeg(frame_count)  # Capturar el siguiente frame
	#else:
		#print("Error al procesar el frame: ", err)
#
## Función para procesar el frame (puedes adaptarla a tus necesidades)
#func process_frame(frame_data: PackedByteArray) -> int:
	#if not texture_rect:
		#print("TextureRect no encontrado")
		#return ERR_DOES_NOT_EXIST
#
	#var image = Image.new()
	#var err = image.load_png_from_buffer(frame_data)
	#if err != OK:
		#print("Error al cargar la imagen desde el buffer: ", err)
		#return err
#
	## Verificar las dimensiones de la imagen
	#print("Dimensiones de la imagen: ", image.get_width(), "x", image.get_height())
#
 	## Verificar las dimensiones de la imagen
	#print("Dimensiones de la imagen: ", image.get_width(), "x", image.get_height())
	#var _loaded_image = image
	#var texture = ImageTexture.create_from_image(image)
	##texture_rect.texture = texture
	#var image_texture = ImageTexture.new()
	##image_texture.create_from_image(image)#
	#texture_rect.texture = texture
	#return OK
#
## Función ready
#func _ready():
	#await start_ffmpeg()
