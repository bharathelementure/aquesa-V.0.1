import 'package:cloud_firestore/cloud_firestore.dart';

class UserMode {
  String id;
  final String displayName;
  final int phoneNumber;
  final String email;
  final String photoURL;

  UserMode(
      {this.id = '',
      required this.displayName,
      required this.email,
      required this.phoneNumber,
      required this.photoURL});

  UserMode copy({
    String? id,
    String? displayName,
    String? email,
    int? phoneNumber,
    String? photoURL,
  }) =>
      UserMode(
          id: id ?? this.id,
          displayName: displayName ?? this.displayName,
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          photoURL: photoURL ?? this.photoURL);

  factory UserMode.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final datafet = document.data()!;
    return UserMode(
        id: document.id,
        displayName: datafet["displayName"],
        email: datafet["email"],
        phoneNumber: datafet["phoneNumber"],
        photoURL: datafet["photoURL"]);
  }

  // receving data from firestore
  factory UserMode.fromMap(map) {
    return UserMode(
        id: map['id'],
        displayName: map['displayName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoURL: 'photoURL');
  }

  // sending data to firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
    };
  }

  factory UserMode.fromjson(Map<String, dynamic> parsedJson) {
    return UserMode(
        displayName: parsedJson['displayName'],
        email: parsedJson['email'],
        phoneNumber: parsedJson['phoneNumber'],
        photoURL: parsedJson['photoURL']);
  }

  static UserMode fromJson(Map<String, dynamic> json) => UserMode(
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      'photoURL': photoURL
    };
  }
}
