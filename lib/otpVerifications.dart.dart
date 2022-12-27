// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/Pages/siginInPage.dart';
import 'package:pinput/pinput.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6294),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WaveWidget(
                  config: CustomConfig(durations: [
                    18000,
                    30000,
                    60000
                  ], heightPercentages: [
                    0.65,
                    0.66,
                    0.68
                  ], colors: [
                    const Color(0xFFAAD7FB),
                    const Color(0xFFA5D4F9),
                    const Color(0xFFFFFFFF)
                  ]),
                  size: const Size(double.infinity, 250),
                  waveAmplitude: 35,
                  backgroundColor: const Color(0xFF2E6294),
                ),
                const SizedBox(
                  height: 45,
                ),
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'raleway',
                      color: Color(0xFF2A3F74)),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Enter the otp sent to",
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'raleway',
                      color: Color(0xFF2A3F74)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn\'t receive the OTP ? ',
                          style: TextStyle(
                              fontFamily: 'raleway',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF676C77)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'RESEND OTP',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'raleway',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF72AFDE)),
                            ))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 234,
                  height: 47,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.all(0)),
                    child: Ink(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF6FADE0), Color(0xFF4483D0)]),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'VERIFY AND PROCEED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: MyPhone.verify, smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/Graph", (route) => false);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "Inncorrect OTP",
                            fontSize: 18,
                            backgroundColor: const Color(0xFF2292D7),
                            textColor: const Color(0xFFFFFFFF));
                        print('otp is inncorrect');
                      }
                    },
                  ),
                ),
                /*Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'phone',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Edit Phone Number ?",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
