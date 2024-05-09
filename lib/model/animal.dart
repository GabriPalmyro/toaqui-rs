// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Animal {
  final String? name;
  final String? phone;
  final String? location;
  final String? photo;
  final DateTime? createdAt;
  final String? additionalInfos;
  final String? physicalInfos;

  Animal({
    this.name,
    this.phone,
    this.location,
    this.photo,
    this.createdAt,
    this.additionalInfos,
    this.physicalInfos,
  });

  Animal copyWith({
    String? name,
    String? phone,
    String? location,
    String? photo,
    DateTime? createdAt,
    String? additionalInfos,
    String? physicalInfos,
  }) {
    return Animal(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      additionalInfos: additionalInfos ?? this.additionalInfos,
      physicalInfos: physicalInfos ?? this.physicalInfos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'location': location,
      'photo': photo,
      'createdAt': createdAt?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
      'additionalInfos': additionalInfos,
      'physicalInfos': physicalInfos,
    };
  }

  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String? : null,
      location: map['location'] != null ? map['location'] as String? : null,
      photo: map['photo'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      additionalInfos: map['additionalInfos'] != null ? map['additionalInfos'] as String : null,
      physicalInfos: map['physicalInfos'] != null ? map['physicalInfos'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Animal.fromJson(String source) => Animal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Animal(name: $name, phone: $phone, location: $location, photo: $photo, additionalInfos: $additionalInfos, physicalInfos: $physicalInfos)';
  }

  @override
  bool operator ==(covariant Animal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.location == location &&
        other.photo == photo &&
        other.additionalInfos == additionalInfos &&
        other.physicalInfos == physicalInfos;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phone.hashCode ^ location.hashCode ^ photo.hashCode ^ additionalInfos.hashCode ^ physicalInfos.hashCode;
  }
}
