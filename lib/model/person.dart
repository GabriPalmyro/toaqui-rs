// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Person {
  final String name;
  final String? age;
  final String? city;
  final String? contactPhone;
  final String? location;
  final String? adress;
  final String? observations;
  final String? parentName;
  final String? photoUrl;
  final DateTime? createdAt;
  final bool isTest;

  Person({
    required this.name,
    this.age,
    this.city,
    this.contactPhone,
    this.location,
    this.adress,
    this.observations,
    this.parentName,
    this.photoUrl,
    this.createdAt,
    this.isTest = false,
  });

  Person copyWith({
    String? name,
    String? age,
    String? city,
    String? contactPhone,
    String? location,
    String? observations,
    String? parentName,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      contactPhone: contactPhone ?? this.contactPhone,
      location: location ?? this.location,
      observations: observations ?? this.observations,
      parentName: parentName ?? this.parentName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'city': city,
      'contact_phone': contactPhone,
      'location': location,
      'observations': observations,
      'adress': adress,
      'parent_name': parentName,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'] as String,
      age: map['age'] != null ? map['age'] as String? : null,
      city: map['city'] != null ? map['city'] as String? : null,
      contactPhone: map['contact_phone'] != null ? map['contact_phone'] as String? : null,
      location: map['location'] as String?,
      adress: map['adress'] != null ? map['adress'] as String? : null,
      observations: map['observations'] != null ? map['observations'] as String? : null,
      parentName: map['parent_name'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isTest: map['test'] != null ? map['test'] as bool : false,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(name: $name, age: $age, city: $city, contactPhone: $contactPhone, location: $location, observations: $observations, parentName: $parentName, photoUrl: $photoUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.age == age &&
        other.city == city &&
        other.contactPhone == contactPhone &&
        other.location == location &&
        other.observations == observations &&
        other.parentName == parentName &&
        other.photoUrl == photoUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        age.hashCode ^
        city.hashCode ^
        contactPhone.hashCode ^
        location.hashCode ^
        observations.hashCode ^
        parentName.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode;
  }
}
