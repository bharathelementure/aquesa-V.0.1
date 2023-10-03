import 'package:cloud_firestore/cloud_firestore.dart';

class UserMode {
  String id;
  final String displayName;
  final int phoneNumber;
  final String email;
  final String photoURL;
  final String flatNo;
  final String property;

  UserMode(
      {this.id = '',
      required this.displayName,
      required this.email,
      required this.phoneNumber,
      required this.photoURL,
      required this.flatNo,
      required this.property});

  UserMode copy(
          {String? id,
          String? displayName,
          String? email,
          int? phoneNumber,
          String? photoURL,
          String? flatNo,
          String? property}) =>
      UserMode(
          id: id ?? this.id,
          displayName: displayName ?? this.displayName,
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          photoURL: photoURL ?? this.photoURL,
          flatNo: flatNo ?? this.flatNo,
          property: property ?? this.property);

  factory UserMode.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final datafet = document.data()!;
    return UserMode(
        id: document.id,
        displayName: datafet["displayName"],
        email: datafet["email"],
        phoneNumber: datafet["phoneNumber"],
        photoURL: datafet["photoURL"],
        flatNo: datafet["flatNo"],
        property: datafet["property"]);
  }

  // receving data from firestore
  factory UserMode.fromMap(map) {
    return UserMode(
        id: map['id'],
        displayName: map['displayName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoURL: 'photoURL',
        flatNo: 'flatNo',
        property: 'property');
  }

  // sending data to firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'flatNo': flatNo,
      'property': property
    };
  }

  factory UserMode.fromjson(Map<String, dynamic> parsedJson) {
    return UserMode(
        displayName: parsedJson['displayName'],
        email: parsedJson['email'],
        phoneNumber: parsedJson['phoneNumber'],
        photoURL: parsedJson['photoURL'],
        flatNo: parsedJson['flatNo'],
        property: parsedJson['property']);
  }

  static UserMode fromJson(Map<String, dynamic> json) => UserMode(
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      id: json['id'],
      flatNo: json['flatNo'],
      property: json['property']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      "photoURL": photoURL,
      "flatNo": flatNo,
      "property": property
    };
  }
}
