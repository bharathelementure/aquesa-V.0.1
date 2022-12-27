import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff12172B),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo_aquesa.png',
                  width: 210,
                  height: 47,
                ),
                const SizedBox(),
                Image.asset(
                  'assets/succ.gif',
                  width: 350,
                  height: 280,
                ),
                const Text(
                  'THANK YOU',
                  style: TextStyle(
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xffFFFFFF)),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'You\'ve successfully created you\'r',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'raleway',
                          color: Color(0xffFFFFFF)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Account Kindly  ',
                          style: TextStyle(
                              fontFamily: 'raleway',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Registration');
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontFamily: 'raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  color: Color(0xff72AFDE)),
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
