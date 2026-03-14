extends Node2D

@onready var http: HTTPRequest = $HTTPRequest

var hand_length := 70.0
var offset: int
var zone: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zone = get_parent().zone
	fetch_time_for_zone(zone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var utc_unix: int = Time.get_unix_time_from_system()
	var zone_unix: int = utc_unix + offset * 3600
	var dt: Dictionary = Time.get_datetime_dict_from_unix_time(zone_unix)
	var time = Time.get_time_dict_from_system()
	var hour: int = dt.hour
	var minute: int = dt.minute
	var second: int = dt.second
	rotation_degrees = (hour % 12) * 30.0 + minute * 0.5
	queue_redraw()
	

func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(0, -hand_length), Color.RED, 10.0)


func fetch_time_for_zone(zone: String) -> void:
	var url = "https://timeapi.io/api/v1/time/current/zone?timezone=%s" % zone.uri_encode()
	var err = http.request(url)
	if err != OK:
		push_error("Błąd startu requestu: %s" % err)
		offset = get_parent().offset

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		push_error("HTTP error: %s" % response_code)
		offset = get_parent().offset
		return
	var json_text := body.get_string_from_utf8()
	var data = JSON.parse_string(json_text)
	
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Nie udało się sparsować JSON'a")
		offset = get_parent().offset
		return
	if data.has("utc_offset_seconds") :
		var request_offset_in_seconds = int(data["utc_offset_seconds"])
		var request_offset_in_hours = request_offset_in_seconds / 3600
		offset = request_offset_in_hours
		var strefa_z_api = data["timezone"]
		print("Wczytanie offset z timeapi powiodło się dla strefy [%s]" % strefa_z_api)
	else:
		offset = get_parent().offset
		print("Wczytanie offset nie powiodło się z timeapi, dlatego ustawiam offset defaultowy [%i]" % offset)
