
class Events {

  String event;
  String type;
  String terrain;

	Events.fromJsonMap(Map<String, dynamic> map): 
		event = map["Event"],
		type = map["Type"],
		terrain = map["Terrain"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Event'] = event;
		data['Type'] = type;
		data['Terrain'] = terrain;
		return data;
	}
}
