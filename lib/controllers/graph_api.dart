import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class consumapi {
  final http.Client client;
  consumapi(this.client);
  Future apiConsumption() async {
    http.Response response;
    response = await client.post(Uri.parse("http://192.168.0.126:8000/csm"));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // setState(() {
      //   stringResponse = response.body;
      // });
    } else {
      return const CircularProgressIndicator();
    }
  }
}
