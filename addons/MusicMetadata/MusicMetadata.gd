@tool
@icon("res://addons/MusicMetadata/icon.svg")
extends Resource
class_name MusicMetadata

## Parses and contains common music file metadata.
##
## This class contains common metadata parsed from music files, with the ability to parse
## (currently only ID3 formatted) metadata from files. The user may also use this as a means to
## store manually defined metadata about music tracks, as the data contained is not automatically
## linked to any changes made after the parsing of a file.
## See [code] MusicMetadataUIBehave [/code] for a UI implementation example (or use it directly).

## Seconds per minute, used for internal calculations.
const SEC_PER_MIN: int = 60

## Maps the series of preset ID3 genere's to their readable genere name
const ID3_GENERE_IDS: Dictionary[String, String] = {
	'0' : "Blues",
	'1' : "Classic Rock",
	'2' : "Country",
	'3' : "Dance",
	'4' : "Disco",
	'5' : "Funk",
	'6' : "Grunge",
	'7' : "Hip-Hop",
	'8' : "Jazz",
	'9' : 'Metal',
	'10' : "New Age",
	'11' : "Oldies",
	'12' : "Other",
	'13' : "Pop",
	'14' : "R&B",
	'15' : "Rap",
	'16' : "Reggae",
	'17' : "Rock",
	'18' : "Techno",
	'19': "Industrial",
	'20' : "Alternative",
	'21' : "Ska",
	'22' : "Death Metal",
	'23' : "Pranks",
	'24' : "Soundtrack",
	'25' : "Euro-Techno",
	'26' : "Ambient",
	'27' : "Trip-Hop",
	'28' : "Vocal",
	'29' : "Jazz+Funk",
	'30' : "Fusion",
	'31' : "Trance",
	'32' : "Classical",
	'33' : "Instrumental",
	'34' : "Acid",
	'35' : "House",
	'36' : "Game",
	'37' : "Sound Clip",
	'38' : "Gospel",
	'39' : "Noise",
	'40' : "Alt. Rock",
	'41' : "Bass",
	'42' : "Soul",
	'43' : "Punk",
	'44' : "Space",
	'45' : "Meditative",
	'46' : "Instrumental Pop",
	'47' : "Instrumental Rock",
	'48' : "Ethnic",
	'49' : "Gothic",
	'50' : "Darkwave",
	'51' : "Techno-Industrial",
	'52' : "Electronic",
	'53' : "Pop-Folk",
	'54' : "Eurodance",
	'55' : "Dream",
	'56' : "Southern Rock",
	'57' : "Comedy",
	'58' : "Cult",
	'59' : "Gangsta Rap",
	'60' : "Top 40",
	'61' : "Christian Rap",
	'62' : "Pop/Funk",
	'63' : "Jungle",
	'64' : "Native American",
	'65' : "Cabaret",
	'66' : "New Wave",
	'67' : "Psychedelic",
	'68' : "Rave",
	'69' : "Showtunes",
	'70' : "Trailer",
	'71' : "Lo-Fi",
	'72' : "Tribal",
	'73' : "Acid Punk",
	'74' : "Acid Jazz",
	'75' : "Polka",
	'76' : "Retro",
	'77' : 'Musical',
	'78' : "Rock & Roll",
	'79' : 'Hard Rock',
	'80' : "Folk",
	'81' : "Folk-Rock",
	'82' : 'National Folk',
	'83' : "Swing",
	'84' : 'Fast-Fusion',
	'85' : 'Bebop',
	'86' : 'Latin',
	'87' : 'Revival',
	'88' : 'Celtic',
	'89' : 'Bluegrass',
	'90' : 'Avantgarde',
	'91' : 'Gothic Rock',
	'92' : 'Progressive Rock',
	'93' : 'Psychedelic Rock',
	'94' : 'Symphonic Rock',
	'95' : 'Slow Rock',
	'96' : 'Big Band',
	'97' : 'Chorus',
	'98' : 'Easy Listening',
	'99' : 'Acoustic',
	'100' : 'Humour',
	'101' : 'Speech',
	'102' : 'Chanson',
	'103' : 'Opera',
	'104' : 'Chamber Music',
	'105' : 'Sonata',
	'106' : 'Symphony',
	'107' : 'Booty Bass',
	'108' : 'Primus',
	'109' : 'Porn Groove',
	'110' : 'Satire',
	'111' : 'Slow Jam',
	'112' : 'Club',
	'113' : 'Tango',
	'114' : 'Samba',
	'115' : 'Folklore',
	'116' : 'Ballad',
	'117' : 'Power Ballad',
	'118' : 'Rhythmic Soul',
	'119' : 'Freestyle',
	'120' : 'Duet',
	'121' : 'Punk Rock',
	'122' : 'Drum Solo',
	'123' : 'A Cappella',
	'124' : 'Euro-House',
	'125' : 'Dance Hall',
	'126' : 'Goa',
	'127' : 'Drum & Bass',
	'128' : 'Club-House',
	'129' : 'Hardcore',
	'130' : 'Terror',
	'131' : 'Indie',
	'132' : 'BritPop',
	'133' : 'Afro-Punk',
	'134' : 'Polsk Punk',
	'135' : 'Beat',
	'136' : 'Christian Gangsta Rap',
	'137' : 'Heavy Metal',
	'138' : 'Black Metal',
	'139' : 'Crossover',
	'140' : 'Contemporary Christian',
	'141' : 'Christian Rock',
	'142' : 'Merengue',
	'143' : 'Salsa',
	'144' : 'Thrash Metal',
	'145' : 'Anime',
	'146' : 'JPop',
	'147' : 'Synthpop',
	'148' : 'Abstract',
	'149' : 'Art Rock',
	'150' : 'Baroque',
	'151' : 'Bhangra',
	'152' : 'Big Beat',
	'153' : 'Breakbeat',
	'154' : 'Chillout',
	'155' : 'Downtempo',
	'156' : 'Dub',
	'157' : 'EBM',
	'158' : 'Eclectic',
	'159' : 'Electro',
	'160' : 'Electroclash',
	'161' : 'Emo',
	'162' : 'Experimental',
	'163' : 'Garage',
	'164' : 'Global',
	'165' : 'IDM',
	'166' : 'Illbient',
	'167' : 'Industro-Goth',
	'168' : 'Jam Band',
	'169' : 'Krautrock',
	'170' : 'Leftfield',
	'171' : 'Lounge',
	'172' : 'Math Rock',
	'173' : 'New Romantic',
	'174' : 'Nu-Breakz',
	'175' : 'Post-Punk',
	'176' : 'Post-Rock',
	'177' : 'Psytrance',
	'178' : 'Shoegaze',
	'179' : 'Space Rock',
	'180' : 'Trop Rock',
	'181' : 'World Music',
	'182' : 'Neoclassical',
	'183' : 'Audiobook',
	'184' : 'Audio Theatre',
	'185' : 'Neue Deutsche Welle',
	'186' : 'Podcast',
	'187' : 'Indie Rock',
	'188' : 'G-Funk',
	'189' : 'Dubstep',
	'190' : 'Garage Rock',
	'191' : 'Psybient',
	'CR' : 'Cover',
	'RX' : 'Remix'
}

## Maps Some ID3 frame names to their human readable names
const ID3_FRAME_ID_TO_URL_NAME: Dictionary[String, String] = {
	"WCOM" : "Commercial",
	'WCOP' : "Copyright",
	'WFED' : "Podcast",
	'WOAF' : "File",
	'WOAR' : "Artist",
	'WOAS' : "Source",
	'WORS' : "InternetRadioStation",
	'WPAY' : "Payment",
	'WPUB' : "Publisher",
	'WXXX' : "Custom",
	'WAF' : "File",
	'WAR' : "Artist",
	'WAS' : "Source",
	'WCM' : "Commercial",
	'WCP' : "Copyright",
	'WPB' : "Publisher",
	'WXX' : "UserDefined"
}

## Used during parsing as the preferred newline to use when parsing requires a newline to be inserted.
var preferred_newline: int = "\n".to_ascii_buffer()[0]

## The track's [i]Beats Per Minute[/i].
@export var bpm: int = 0
## The track's [i]Beats Per Second[/i]. Uses [member bpm] as a backing varible.
@export var bps:int:
	get:
		return bpm * SEC_PER_MIN
	set(_value):
		bpm = int(_value / SEC_PER_MIN)
## The track's [i]Title[/i].
@export var title: String = ""
## The track's [i]Album Name[/i].
@export var album: String = ""
## The track's [i]Number[/i].
@export var track_no:int = -1
## The track's [i]Artist[/i].
@export var artist: String = ""
## The track's [i]Album's Artist[/i]. This is also known as the [i]Band Name[/i].
@export var album_artist: String = ""
## The track's [i]Cover Image[/i].
@export var cover: ImageTexture = null
## The track's [i]Genere[/i].
@export var genere:String = ""
## The track's [i]Year[/i].
@export var year: int = 0
## The track's [i]Date[/i].
@export var date:String = ""
## The track's [i]Comments[/i].
@export_multiline var comments: String = ""
## The track's [i]User Defined Text[/i].
@export_multiline var user_defined_text: String = ""
## The track's [i]Urls[/i].
## It's keys are of [String]s with the type of url, it's values are of [String]s with the url.
@export var urls:Dictionary[String, String] = {}
## The track's [i]Copyright Message[/i].
@export var copyright:String = ""
## The track's [i]Terms Of Use[/i].
@export var terms_of_use:String = ""

## Create a [MusicMetadata] [Resource].
## If not [code] null [/code], [param source] will update the new [MusicMetadata] [Resource]
## with any appropriate data found.
func _init(source:Variant = null) -> void:
	if source != null:
		if source is Array:
			source = PackedByteArray(source)

		if source is PackedByteArray:
			set_from_data(source)
		elif source is AudioStream:
			set_from_stream(source)

## Updates the metadata object's values based off of the data found in [param stream].
## Only works with [AudioStreamMP3], [AudioStreamOggVorbis], and [AudioStreamWAV] streams.
## See the [b]note[/b] in [method MusicMetadata.set_from_wav_stream]
## for information regarding parsing [AudioStreamWAV] stream's metadata.
func set_from_stream(stream: AudioStream) -> void:
	if stream is AudioStreamMP3:
		set_from_MP3_stream(stream)
	elif stream is AudioStreamOggVorbis:
		set_from_oggvorbis_stream(stream)
	elif stream is AudioStreamWAV:
		set_from_wav_stream(stream)
	else:
		push_warning("Stream type not supported")

## Updates the metadata object's values from the data found in the [AudioStreamMP3] [param stream].
func set_from_MP3_stream(stream:AudioStreamMP3) -> void:
	assert(stream != null and stream.data != null, "Stream must contain data")
	set_from_data(stream.data)

## Updates the metadata object's values from the data found in the [AudioStreamOggVorbis] [param stream].
func set_from_oggvorbis_stream(stream:AudioStreamOggVorbis) -> void:
	assert(stream != null and stream.data != null, "Stream must contain data")
	set_from_data(stream.data)

## Updates the metadata object's values based from data found in the [AudioStreamWAV] [param stream].
## NOTE: Due to the way Godot handles WAV streams, it is likely the data contained within a
## [AudioStreamWAV] object will have its metadata stripped form it.
## because of this, it is strongly suggested to instead pars the raw data form the file itself using
## [method MusicMetadata.set_from_data] instead, unless you are sure that the metadata required will not
## be stripped by Godot.
func set_from_wav_stream(stream: AudioStreamWAV) -> void:
	assert(stream != null and stream.data != null, "Stream must contain data")
	set_from_data(stream.data)

## Updates the metadata object's values based from data found in the [PackedByteArray] [param data].
func set_from_data(data: PackedByteArray):
	if data.size() < 10:
		push_error("Error: Stream data is too small.")
		return

	var header: PackedByteArray = data.slice(0, 10)
	var id3_id: String = header.slice(0, 3).get_string_from_ascii()
	
	if id3_id == "ID3":
		var v: String = "ID3v2.%d.%d" % [header[3], header[4]]
		set_from_ID3_data(data, v)
	elif data.slice(-32, -28).get_string_from_ascii() == "APETAGEX":
		set_from_APEv2_data(data)
	elif data.slice(0, 4).get_string_from_ascii() == "OggS":
		set_from_vorbis_comments(data)
	elif data.slice(0, 4).get_string_from_ascii() == "RIFF":
		set_from_riff_info(data)
	else:
		# Prova a cercare un tag ID3v1 alla fine del file
		var id3v1_tag = data.slice(-128)
		if id3v1_tag.slice(0, 3).get_string_from_ascii() == "TAG":
			set_from_ID3v1_data(id3v1_tag)
		else:
			push_warning("Unknown metadata format")

## Imposta i valori dei metadati dai dati ID3v1 trovati nel [PackedByteArray] [param data].
func set_from_ID3v1_data(data: PackedByteArray) -> void:
	title = data.slice(3, 33).get_string_from_ascii().strip_edges()
	artist = data.slice(33, 63).get_string_from_ascii().strip_edges()
	album = data.slice(63, 93).get_string_from_ascii().strip_edges()
	year = data.slice(93, 97).get_string_from_ascii().to_int()
	if data[97] == 0:
		comments = data.slice(97, 125).get_string_from_ascii().strip_edges()
		track_no = data[126]
	else:
		comments = data.slice(97, 127).get_string_from_ascii().strip_edges()
	genere = ID3_GENERE_IDS.get(str(data[127]), "Unknown")

## Tenta di impostare i valori dei metadati da un formato sconosciuto.
func set_from_unknown_format(data: PackedByteArray) -> void:
	# Implementa qui la logica per rilevare e analizzare altri formati di metadati
	# Ad esempio, potresti cercare stringhe specifiche o strutture di dati note
	pass


## Updates the metadata object's values from the ID3 data found in the [PackedByteArray] [param data].
## The specific version of ID3 data must also be specified in [param ver].
func set_from_ID3_data(data: PackedByteArray, ver: String) -> void:
	var header: PackedByteArray = data.slice(0, 10)
	var null_as_separator: bool = (ver == "ID3v2.4.0" or ver == "ID3v2.3.0")
	var flags: int = header[5]
	var unsync: bool = flags & 0x80 > 0
	var extended: bool = flags & 0x40 > 0
	var experimental: bool = flags & 0x20 > 0
	var has_footer: bool = flags & 0x10 > 0
	var idx: int = 10
	var end: int = idx + _bytes_to_int(header.slice(6, 10))

	if extended:
		idx += _bytes_to_int(data.slice(idx, idx + 4))

	while idx < end:
		var frame_id: String = data.slice(idx, idx + 4).get_string_from_ascii()
		var size: int = _bytes_to_int(data.slice(idx + 4, idx + 8), frame_id != "APIC")

		# Se maggiore di byte, non è un numero sync safe (0b0111_1111 -> 0x7f)
		if size > 0x7f:
			size = _bytes_to_int(data.slice(idx + 4, idx + 8), false)
		idx += 10

		var frame_data: PackedByteArray = data.slice(idx, idx + size)
		if frame_data.size() > 0:
			if unsync:
				frame_data = _unsynchronize(frame_data)
			set_value_from_ID3_frame(frame_id, frame_data, null_as_separator)

		idx += size

## Imposta i valori dei metadati dai dati APEv2 trovati nel [PackedByteArray] [param data].
func set_from_APEv2_data(data: PackedByteArray) -> void:
	var footer = data.slice(-32)
	var version = footer.decode_u32(8)
	var size = footer.decode_u32(12)
	var count = footer.decode_u32(16)
	
	var tags = data.slice(-size, -32)
	var offset = 0
	
	for i: int in range(count):
		var tag_size = tags.decode_u32(offset)
		offset += 4
		var flags = tags.decode_u32(offset)
		offset += 4
		var key_end = tags.find(0, offset)
		var key = tags.slice(offset, key_end).get_string_from_utf8()
		offset = key_end + 1
		var value = tags.slice(offset, offset + tag_size).get_string_from_utf8()
		offset += tag_size
		
		match key.to_lower():
			"title": title = value
			"artist": artist = value
			"album": album = value
			"year": year = value.to_int()
			"track": track_no = value.to_int()
			"genre": genere = value
			"comment": comments = value

## Imposta i valori dei metadati dai Vorbis Comments trovati nel [PackedByteArray] [param data].
func set_from_vorbis_comments(data: PackedByteArray) -> void:
	var vendor_length := data.decode_u32(7)
	var offset := 11 + vendor_length
	var comment_list_length := data.decode_u32(offset)
	offset += 4
	
	for i: int in range(comment_list_length):
		var length := data.decode_u32(offset)
		offset += 4
		var comment := data.slice(offset, offset + length).get_string_from_utf8()
		offset += length
		
		var parts := comment.split("=")
		if parts.size() == 2:
			match parts[0].to_lower():
				"title": title = parts[1]
				"artist": artist = parts[1]
				"album": album = parts[1]
				"date": year = parts[1].to_int()
				"tracknumber": track_no = parts[1].to_int()
				"genre": genere = parts[1]
				"comment": comments = parts[1]

## Imposta i valori dei metadati dai RIFF INFO tags trovati nel [PackedByteArray] [param data].
func set_from_riff_info(data: PackedByteArray) -> void:
	var list_tag := "LIST".to_ascii_buffer()
	var offset := 0
	
	# Cerca il tag "LIST"
	while offset < data.size() - 4:
		if data.slice(offset, offset + 4) == list_tag:
			break
		offset += 1
	
	if offset >= data.size() - 4:
		push_warning("RIFF LIST chunk not found")
		return
	
	offset += 4  # Salta "LIST"
	var chunk_size := data.decode_u32(offset)
	offset += 4
	
	var end_offset = offset + chunk_size
	
	while offset < end_offset:
		var chunk_id := data.slice(offset, offset + 4).get_string_from_ascii()
		offset += 4
		var chunk_data_size := data.decode_u32(offset)
		offset += 4
		var value := data.slice(offset, offset + chunk_data_size).get_string_from_utf8().strip_edges()
		offset += chunk_data_size
		
		# Assicuriamoci che l'offset sia allineato a 2 byte
		if offset % 2 != 0:
			offset += 1
		
		match chunk_id:
			"INAM": title = value
			"IART": artist = value
			"IPRD": album = value
			"ICRD": year = value.to_int() if value.is_valid_int() else 0
			"ITRK": track_no = value.to_int() if value.is_valid_int() else 0
			"IGNR": genere = value
			"ICMT": comments = value

## Desincronizza i dati del frame.
func _unsynchronize(data: PackedByteArray) -> PackedByteArray:
	var result: PackedByteArray = PackedByteArray()
	var i: int = 0
	while i < data.size():
		result.append(data[i])
		if data[i] == 0xFF and i + 1 < data.size() and data[i + 1] & 0xE0 == 0xE0:
			result.append(0x00)
		i += 1
	return result

## Prints some of the metadata info to the output.
func print_info() -> void:
	print("bpm: ", bpm)
	print("title: ", title)
	print("album: ", album)
	print("comments: ", comments)
	print("year: ", year)
	print("cover: ", cover)
	print("artist: ", artist)

## Updates a specific value from the given ID3 data frame's value.
## [param frame_name] is the [String] name of the frame.
## [param sliced_frame_data] in the specific binary data found in the ID3 frame.
## [param null_as_sep] is an optional setting.
## When true, a [code] null [/code] value will be treated as a newline,
## instead of terminating the data, if its to be read as a string.
## Used internally when a ID3 frame is found when parsing binary data.
func set_value_from_ID3_frame(frame_name: String, sliced_frame_data: PackedByteArray, null_as_sep: bool = false) -> void:
	if sliced_frame_data.size() <= 0:
		print("DEBUG: Bad data provided for frame ", frame_name)
		return
	
	match frame_name:
		"TBPM", 'TBP':
			bpm = int(_get_string_from_ID3data(sliced_frame_data))
		"TIT2", 'TT2':
			title = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TALB", 'TAL':
			album = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"COMM", "COM":
			comments = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TXX", "TXXX":
			user_defined_text += _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TCOP", "TCR":
			copyright += _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TDAT", "TDA":
			date = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TYER", "TYE":
			year = int(_get_string_from_ID3data(sliced_frame_data))
		"TPE1", 'TP1':
			artist = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TPE2", 'TP2':
			album_artist = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TRCK", 'TRK':
			track_no = int(_get_string_from_ID3data(sliced_frame_data))
		"USER":
			terms_of_use = _get_string_from_ID3data(sliced_frame_data, null_as_sep)
		"TCON", 'TCO':

			var gen_key: String = _get_string_from_ID3data(sliced_frame_data, null_as_sep)

			gen_key = gen_key.strip_escapes().strip_edges()

			
			if gen_key.is_empty():
				print("DEBUG: Empty genre value, skipping further processing")
				return
			

			
			while gen_key.length() >= 2 and gen_key[0] == "(" and gen_key[-1] == ")":

				gen_key = gen_key.substr(1, gen_key.length() - 2)

			
			if gen_key.is_valid_int():

				gen_key = str(int(gen_key))
			
			if gen_key in ID3_GENERE_IDS:
				genere = ID3_GENERE_IDS[gen_key]

			else:
				genere = gen_key

		"APIC", 'PIC':
			sliced_frame_data = sliced_frame_data.slice(1)
			var zero1: float = sliced_frame_data.find(0)
			
			if zero1 <= 0:
				assert(false, "bad cover photo")
				return
			
			var mime_type: String = sliced_frame_data.slice(0, zero1).get_string_from_ascii()
			
			zero1 += 1 # Picture type
			if zero1 >= sliced_frame_data.size():
				assert(false, "bad cover photo")
				return
				
			zero1 += 1
			if zero1 >= sliced_frame_data.size():
				assert(false, "bad cover photo")
				return
				
			var zero2: float = sliced_frame_data.find(0, zero1)
			var image_bytes: PackedByteArray = sliced_frame_data.slice(zero2 + 1)
			
			var img: Image = Image.new()
			match mime_type:
				"image/png":
					img.load_png_from_buffer(image_bytes)
				"image/jpeg", "image/jpg":
					img.load_jpg_from_buffer(image_bytes)
				_:
					assert(false, "mime type %s not yet supported..." % [mime_type])
					return
			cover = ImageTexture.create_from_image(img)
		var fr_id when fr_id in ID3_FRAME_ID_TO_URL_NAME.keys():
			urls[ID3_FRAME_ID_TO_URL_NAME[fr_id]] = _get_string_from_ID3data(sliced_frame_data)

# ## This is intended to be private.
# ## The hash of a USC string declaration. Used for compairson.
var _USC_STRING_DECLARATION_HASH:int = [1, 0xff, 0xfe].hash()
# ## This method is intended to be private.
# ## Gets a string from the given ID3 formated [param data]. Accounts for USC formated strings.
func _get_string_from_ID3data(data: PackedByteArray, null_to_newline:bool = false) -> String:
	var ret: String = ""
	
	if data.size() > 3 and Array(data.slice(0, 3)).hash() == _USC_STRING_DECLARATION_HASH:
		# Null-terminated string of ucs2 chars
		ret = _get_string_from_ucs2(data.slice(3), null_to_newline)
	
	if ret == "" and data[0] == 0:
		# Simple utf8 string
		if null_to_newline:
			data = _byte_array_replace(data, 0, preferred_newline)
		ret = data.slice(1).get_string_from_utf8()
	
	return ret

# ## This method is intended to be private.
# ## Gets a [String] from a USC formated [Array] of bytes.
# ## Assumes that the given [param bytes] are USC formated (does not check).
func _get_string_from_ucs2(bytes: PackedByteArray, null_to_newline:bool = false) -> String:
	var s:String = ""
	var idx:int = 0
	while idx < (bytes.size() - 1):
		var c = bytes[idx] + 256 * bytes[idx + 1]
		if null_to_newline and c == 0:
			c = preferred_newline
		c = char(c)
		s += c
		idx += 2
	return s

# ## This method is intended to be private.
# ## Replaces a instance of byte '[param this]' with the byte '[param with]' in the byte array.
# ## Instead of modifying the original [param byte_array], this returns a modified copy.
func _byte_array_replace(byte_array: PackedByteArray, this:int, with:int) -> PackedByteArray:
	byte_array = byte_array.duplicate()
	while byte_array.has(this):
		var ind: int = byte_array.find(this)
		byte_array[ind] = with
	return byte_array

# ## This method is intended to be private.
# ## Converts a given [Array] of [param bytes] into a [int],
# ## also accounting for a syncsafe formated int when [param is_syncsafe] is set.
func _bytes_to_int(bytes: PackedByteArray, is_syncsafe = true) -> int:
	# Syncsafe uses 0x80 multiplier otherwise use 0x100 multiplier
	var mult:int = 0x80 if is_syncsafe else 0x100
	var n:int = 0
	for byte: int in bytes:
		n *= mult
		n += byte
	return n
