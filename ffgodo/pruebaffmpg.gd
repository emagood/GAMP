extends Control
#
#@onready var texture_rect = $TextureRect
#
## Función para iniciar el proceso FFmpeg y manejar la salida
#func start_ffmpeg():
	#var command = "ffmpeg"
	#var args = [
		#"-i", "input_video.mp4",
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
#
	#while not stdio.eof_reached():
		## Ajusta el tamaño del buffer según la resolución y el formato de color
		#var frame_data = stdio.get_buffer(1920 * 1080)  # Usar un buffer de tamaño adecuado
		#if frame_data.size() == 0:
			#break
#
		#print("Bytes leídos: ", frame_data.size())
#
		#if process_frame(frame_data) == ERR_PARSE_ERROR:
			#print("Error al procesar el frame")
#
## Función para procesar el frame (puedes adaptarla a tus necesidades)
#func process_frame(frame_data: PackedByteArray) -> int:
	#var image = Image.new()
	#var err = image.load_png_from_buffer(frame_data)
	#if err != OK:
		#print("Error al cargar la imagen desde el buffer: ", err)
		#return ERR_PARSE_ERROR
#
	#var image_texture = ImageTexture.new()
	#image_texture.create_from_image(image)
	#texture_rect.texture = image_texture
	#return OK
#
## Función ready
#func _ready():
	#start_ffmpeg()
