import 'dart:convert';

Zone zoneFromJson(String str) => Zone.fromJson(json.decode(str));

String zoneToJson(Zone data) => json.encode(data.toJson());

class Zone {
  final int id;
  final String name;

  Zone({required this.id, required this.name});

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
