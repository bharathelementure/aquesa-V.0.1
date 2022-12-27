// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class NameDevice extends StatefulWidget {
  const NameDevice({Key? key}) : super(key: key);

  @override
  State<NameDevice> createState() => _NameDeviceState();
}

class _NameDeviceState extends State<NameDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Icon(
                Icons.account_circle_rounded,
                color: Color(0xFFA5D4F9),
                size: 32,
              ),
            )
          ],
        ),
      ),
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF72AFDE),
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.account_circle,
                  color: Color(0xFFFFFFFF),
                  size: 27,
                ));
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Column(mainAxisAlignment: MainAxisAlignment.start,
            //wave widget
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
            size: const Size(double.infinity, 175),
            waveAmplitude: 35,
            backgroundColor: const Color(0xFF72AFDE),
          ),
          //first bar
          const SizedBox(
            height: 0,
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(15),
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 10),
                        blurRadius: 20,
                        color:
                            const Color(0xFF000000).withOpacity(0.25)),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Name the device',
                        style: TextStyle(
                            fontFamily: 'raleway',
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: Color(0xFF2A3F74)),
                      ),
                      SizedBox(
                        height: 54,
                      ),
                      Text(
                        'The app will require access',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'raleway'),
                      )
                    ],
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/paymentsInvoices');
                    },
                    backgroundColor: const Color(0xFF2A3F74),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFFFFFFFF),
                      size: 50,
                    ),
                  )
                ],
              )),
          //second bar
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(11),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                      color: const Color(0xFF000000).withOpacity(0.25))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor:  Color(0xFFC4C4C4),
                  radius: 20,
                ),
                const Text(
                  'Bathroom',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w500,
                      color:  Color(0xFF2A3F74)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'raleway',
                          fontSize: 12,
                          color: Color(0xFF4483D0)),
                    ))
              ],
            ),
          ),
          //third bar
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(11),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                      color: const Color(0xFF000000).withOpacity(0.25))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFC4C4C4),
                  radius: 20,
                ),
                const Text(
                  'Kitchen',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2A3F74)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'raleway',
                          fontSize: 12,
                          color: Color(0xFF4483D0)),
                    ))
              ],
            ),
          ),
          //fourth bar
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(11),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                      color: const Color(0xFF000000).withOpacity(0.25))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor:  Color(0xFFC4C4C4),
                  radius: 20,
                ),
                const Text(
                  'Powder Room',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2A3F74)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'raleway',
                          fontSize: 12,
                          color: Color(0xFF4483D0)),
                    ))
              ],
            ),
          ),
          //fifth bar
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(11),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                      color: const Color(0xFF000000).withOpacity(0.25))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFC4C4C4),
                  radius: 20,
                ),
                const Text(
                  'Utility',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2A3F74)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'raleway',
                          fontSize: 12,
                          color: Color(0xFF4483D0)),
                    ))
              ],
            ),
          )
        ])
      ]),
    );
  }
}
