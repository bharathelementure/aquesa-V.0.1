import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/createAccountPage.dart';
import 'package:otp_auth/Pages/siginInPage.dart';
import 'package:otp_auth/registration.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin?const Registration()
      // MyPhone(onClickedSignUp: toggle) 
      : CreateAcountPage(onClickedSignIn: toggle);

      void toggle() => setState(() => isLogin = !isLogin);
}
