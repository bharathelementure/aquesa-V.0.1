
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AllPage extends StatelessWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(8),
                  height: 85,
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        color:  Color(0xFF2A3F74),
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Monthly bill generated',
                            style: TextStyle(
                                fontFamily: 'raleway',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color(0xFF2A3F74)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '04 October, 2022',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                color: Color(0xFF2A3F74)),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/graph');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xFF2A3F74),
                            size: 32,
                          ))
                    ],
                  ),
                ),
                //second bar
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(8),
                  height: 85,
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.water_drop_rounded,
                        color: Color(0xFF2A3F74),
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Leakage Detected',
                            style: TextStyle(
                                fontFamily: 'raleway',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color(0xFFDA0000)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Kitchen Shaft',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'inter',
                                color: Color(0xFF2A3F74)),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/qrCodeScanner');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xFF2A3F74),
                            size: 32,
                          ))
                    ],
                  ),
                ),
                //third bar
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(8),
                  height: 85,
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        color:  Color(0xFF2A3F74),
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Monthly bill generated',
                            style: TextStyle(
                                fontFamily: 'raleway',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color(0xFFA3A3A3)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '04 September, 2022',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                color: Color(0xFFA3A3A3)),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color:  Color(0xFFA3A3A3),
                            size: 32,
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
