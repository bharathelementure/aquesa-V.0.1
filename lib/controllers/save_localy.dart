import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_auth/models/user_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUserOffline(UserMode userMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = convertObjectToString(userMode);
  prefs.setString("userMode", jsonString);
  prefs.getString("userMode");
}

String convertObjectToString(UserMode userMode) {
  String json = jsonEncode(userMode);
  debugPrint("This is json $json");
  return json;
}
