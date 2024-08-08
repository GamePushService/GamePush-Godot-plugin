@tool
extends EditorExportPlugin
class_name  HTMLExportPlugin


var plugin_path: String = get_script().resource_path.get_base_dir()
var export_path: String

var project_id: String
var public_token: String 
var is_archive := false
var archive_name := 'export_archive.zip'

func _get_name() -> String:
	return "Game Push"


func _export_begin(features: PackedStringArray , is_debug: bool, path: String, flags: int) -> void:
	export_path = path
	

func _export_end() -> void:
	var file := FileAccess.open(export_path, FileAccess.READ)
	var html := file.get_as_text()
	file.close()
	var pos = html.find('</head>')
	html = html.insert(pos, 
				'<script async src= "https://gamepush.com/sdk/game-score.js?projectId=%s&publicToken=%s&callback=onGPInit"></script>\n 
				<script>
					let gp
					window.onGPInit = async (_gp) => {
						window.gp = _gp;
					};
				</script>\n' % [project_id, public_token])
	file = FileAccess.open(export_path, FileAccess.WRITE)
	file.store_string(html)
	file.close()
	if is_archive:
		zip_export(archive_name)


func zip_export(name_file:String):
	var writer := ZIPPacker.new()
	var archive_path :String = export_path.get_base_dir() + "/" + name_file
	var err := writer.open(archive_path)
	if err != OK:
		push_error("Error open zip file")
	var all_files = DirAccess.open(export_path.get_base_dir()).get_files()
	for f in all_files:
		var file_path = export_path.get_base_dir() + '/' + f
		if file_path == archive_path:
			continue
		var file_object = FileAccess.open(file_path, FileAccess.READ)
		var file_content = file_object.get_file_as_bytes(file_path)
		file_object.close()
		writer.start_file(f)
		writer.write_file(file_content)