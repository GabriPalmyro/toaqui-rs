// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Shelter {
  String name;
  String location;
  double latitude;
  double longitude;

  Shelter({
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  Shelter copyWith({
    String? name,
    String? location,
    double? latitude,
    double? longitude,
  }) {
    return Shelter(
      name: name ?? this.name,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Shelter.fromMap(Map<String, dynamic> map) {
    return Shelter(
      name: map['name'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shelter.fromJson(String source) => Shelter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shelter(name: $name, location: $location, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant Shelter other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.location == location &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      location.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
