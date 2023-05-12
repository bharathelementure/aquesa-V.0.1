import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'image_picke.dart';

updateProfile(BuildContext context) async {
  Map<String, dynamic> map = {};
  if (file != null) {
    String url = await uploadImage();
    map['photoURL'] = url;
  }
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update(map);
  Navigator.pop(context);
}

Future<String> uploadImage() async {
  TaskSnapshot taskSnapshot = await FirebaseStorage.instance
      .ref()
      .child("profileimage")
      .child(
          "${FirebaseAuth.instance.currentUser!.uid}_${basename(file!.path)}")
      .putFile(file!);
  return taskSnapshot.ref.getDownloadURL();
}
