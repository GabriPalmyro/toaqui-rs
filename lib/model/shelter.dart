// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Shelter {
  String name;
  String location;
  double latitude;
  double longitude;
  List<String> needs; // New property

  Shelter({
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.needs = const [], // Initialize with an empty list
  });

  Shelter copyWith({
    String? name,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? needs,
  }) {
    return Shelter(
      name: name ?? this.name,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      needs: needs ?? this.needs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'needs': needs,
    };
  }

  factory Shelter.fromMap(Map<String, dynamic> map) {
    return Shelter(
      name: map['name'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      needs: List<String>.from(map['needs'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shelter.fromJson(String source) => Shelter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shelter(name: $name, location: $location, latitude: $latitude, longitude: $longitude, needs: $needs)';
  }

  @override
  bool operator ==(covariant Shelter other) {
    if (identical(this, other)) return true;

    return other.name == name && other.location == location && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode {
    return name.hashCode ^ location.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ needs.hashCode;
  }
}
