// ignore_for_file: avoid_print, body_might_complete_normally_catch_error

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/Pages/forgot_password_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MyPhone extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const MyPhone({super.key, required this.onClickedSignUp});

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  var phone = '';
  // pasword show or hide
  bool isObscure = true;

  @override
  void initState() {
    numberController.text = '+91';
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
            /*Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child:*/
            SingleChildScrollView(
                // reverse: true,
                child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            WaveWidget(
              config: CustomConfig(durations: [
                18000,
                30000,
                60000,
                22000
              ], heightPercentages: [
                0.55,
                0.65,
                0.66,
                0.68
              ], colors: [
                const Color(0xFF2292D7),
                const Color(0xFFAAD7FB),
                const Color(0xFFA5D4F9),
                const Color(0xFFFFFFFF)
              ]),
              size: const Size(double.infinity, 200),
              waveAmplitude: 35,
              backgroundColor: const Color(0xFF2E6294),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'raleway',
                  color: Color(0xFF2A3F74)),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Enter your email & password',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'raleway',
                  color: Color(0xFF2A3F74)),
            ),
            const SizedBox(height: 30),
            const SizedBox(width: 10),
            // Padding(padding: EdgeInsets.all(20)),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 0),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      key: const Key('email'),
                      controller: emailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a Valid email'
                              : null,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Password Controller
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      key: const Key('password'),
                      controller: passwordController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min. 6 characters'
                          : null,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: Icon(isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      obscureText: isObscure,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
                width: 214,
                height: 47,
                child: ElevatedButton(
                    key: const Key('signInbtn'),
                    style: ElevatedButton.styleFrom(
                        // primary: const Color(0xFF6FADE0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () {
                      signIn(emailController.text, passwordController.text);
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF6FADE0), Color(0xFF4483D0)]),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))),
            const SizedBox(height: 24),
            GestureDetector(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage())),
            ),
          ])
        ])));
    /*onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: numberController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                           Fluttertoast.showToast(msg: "Please Enter a Valid number",
                        fontSize: 18,
                        backgroundColor: const Color(0xFF2292D7),
                        textColor: const Color(0xFFFFFFFF)
                        );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          Navigator.pushNamed(context, '/OTPVerification');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },*/
  }

// Phone number otp
  Future verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: numberController.text + phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(
            msg: "Please Enter a Valid number",
            fontSize: 18,
            backgroundColor: const Color(0xFF2292D7),
            textColor: const Color(0xFFFFFFFF));
      },
      codeSent: (String verificationId, int? resendToken) {
        MyPhone.verify = verificationId;
        Navigator.pushNamed(context, '/OTPVerification');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

// email verification
  void signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((id) => {
                Fluttertoast.showToast(msg: 'Login Successfull'),
                Navigator.of(context).popUntil((route) => route.isFirst)
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: '${e.message}',
            // msg: "Incorrect email or password",
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16);
      });
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
