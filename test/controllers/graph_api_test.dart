import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:otp_auth/controllers/graph_api.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('consumapi', () {
    test('apiConsumption returns response body on successful request', () async {
      // Create a mock http.Client
      final mockClient = MockClient();

      // Create an instance of consumapi with the mock client
      final api = consumapi(mockClient);

      // Create a mock response with status code 200 and a response body
      final mockResponse = http.Response('Success', 200);

      // Mock the post method of the mock client to return the mock response
      when(mockClient.post(any as Uri) as Function()).thenAnswer((_) async => mockResponse);

      // Call the apiConsumption method
      final result = await api.apiConsumption();

      // Verify that the mock client's post method was called with the correct URI
      verify(mockClient.post(Uri.parse("http://192.168.0.126:8000/csm")) as Function());

      // Verify that the result is equal to the response body
      expect(result, equals('Success'));
    });

    test('apiConsumption returns CircularProgressIndicator on unsuccessful request', () async {
      // Create a mock http.Client
      final mockClient = MockClient();

      // Create an instance of consumapi with the mock client
      final api = consumapi(mockClient);

      // Create a mock response with a non-200 status code
      final mockResponse = http.Response('Error', 400);

      // Mock the post method of the mock client to return the mock response
      when(mockClient.post(any as Uri) as Function()).thenAnswer((_) async => mockResponse);

      // Call the apiConsumption method
      final result = await api.apiConsumption();

      // Verify that the mock client's post method was called with the correct URI
      verify(mockClient.post(Uri.parse("http://192.168.0.126:8000/csm")) as Function());

      // Verify that the result is a CircularProgressIndicator
      expect(result, isA<CircularProgressIndicator>());
    });
  });
}
