import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/Screens/home.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
      await Future.error(Exception(user));
      setState(() => FirebaseAuth.instance.signOut());
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Email verification required!',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Graph()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Email Verify'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to your email',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: const Icon(Icons.message),
                    label: const Text('Resend Email')),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Cancel'))
              ],
            ),
          ),
        );
}