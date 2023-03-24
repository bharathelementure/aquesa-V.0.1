import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? Name;
  int? phone;
  String? email;
  String? uid;

  UserModel({this.uid, this.Name, this.phone, this.email});
}

// receving data from server
/*factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        Name: map['Name'],
        phone: map['phone']);
  }
  
  // sending data to over server
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'Name': Name, 'phone': phone};
  }
}
*/

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    required String Name,
    required String email,
    required int phone,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "Name": Name,
      "email": email,
      "phone": phone,
      "userUid": currentUser.uid
    });
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
          email: value.get("email"),
          Name: value.get("Name"),
          phone: value.get("phone"),
          uid: value.get("userUid"));
      currentData = UserModel as UserModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}
