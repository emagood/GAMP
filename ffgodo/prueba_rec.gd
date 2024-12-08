'''

 FUNCIONA 


'''


extends Control
#
#@onready var texture_rect = $TextureRect
#
## Función para iniciar el proceso FFmpeg y manejar la salida
#func start_ffmpeg():
	#var command = "ffmpeg"
	#var args = [
		#"-i", "input_video.mp4",
		#"-frames:v", "1",  # Capturar solo un frame
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
	## Leer todos los datos del frame
	#while not stdio.eof_reached():
		#var chunk = stdio.get_buffer(8192)  # Leer en bloques de 8 KB
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
	#else:
		#print("Error al procesar el frame: ", err)
#
## Función para procesar el frame (puedes adaptarla a tus necesidades)
#func process_frame(frame_data: PackedByteArray) -> int:
	#var image = Image.new()
	#var err = image.load_png_from_buffer(frame_data)
	#if err != OK:
		#print("Error al cargar la imagen desde el buffer: ", err)
		#return err
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
	#start_ffmpeg()
