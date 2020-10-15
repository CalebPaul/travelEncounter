import 'package:travel_encounters/Events.dart';
import 'Events.dart';

class EncounterModel {
  List<Events> events;

  EncounterModel.fromJsonMap(Map<String, dynamic> map)
      : events = List<Events>.from(
            map["Events"].map((it) => Events.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Events'] =
        Events != null ? this.events.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
