import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Reset Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Recieve an email to \n reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: 'Email'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.email_outlined),
                  label: const Text(
                    'Reset password',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: verifyEmail,
                )
              ],
            ),
          ),
        ),
      );

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: '${e.message}',
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16);
      Navigator.of(context).pop();
    }
  }
}
