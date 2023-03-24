// ignore_for_file: empty_catches, unused_field, use_build_context_synchronously, file_names

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:otp_auth/main.dart';
// import 'package:otp_auth/registration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _hasSensor;

  LocalAuthentication authentication = LocalAuthentication();
  bool _isauthenticating = false;

  Future<void> _checkBio() async {
    try {
      _hasSensor = await authentication.canCheckBiometrics;

      if (_hasSensor!) {
        _getAuth();
      }
    } on PlatformException {}
  }

  @override
  void initState() {
    super.initState();
    _checkBio();
    _isauthenticating = true;
  }

  Future<void> _getAuth() async {
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
          localizedReason: 'Scan your finger to access the app',
          options: const AuthenticationOptions(
              stickyAuth: true, useErrorDialogs: true));
      if (isAuth) {
        _isauthenticating = true;
        Navigator.pushNamed(context, '');
      }
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo_aquesa.png',
      nextScreen: const Intializer(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xFF72AFDE),
      duration: 1500,
    );
  }
}
