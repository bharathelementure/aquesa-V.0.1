import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/create_account_page.dart';
import 'package:otp_auth/Screens/registration.dart';

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
