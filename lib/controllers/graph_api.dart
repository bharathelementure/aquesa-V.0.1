import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future apiConsumption() async {
  http.Response response;
  response = await http.post(Uri.parse("http://192.168.0.126:8000/csm"));
  if (response.statusCode == 200) {
    print(response.body);
    // setState(() {
    //   stringResponse = response.body;
    // });
  } else {
    return const CircularProgressIndicator();
  }
}
