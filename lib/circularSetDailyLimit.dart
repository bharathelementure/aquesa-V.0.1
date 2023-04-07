// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CircularSetDailyLimit extends StatefulWidget {
  const CircularSetDailyLimit({Key? key}) : super(key: key);

  @override
  State<CircularSetDailyLimit> createState() => _CircularSetDailyLimitState();
}

class _CircularSetDailyLimitState extends State<CircularSetDailyLimit> {
  double _volumeValue = 10;

  void onVolumeChanged(double value) {
    setState(() {
      _volumeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          actions: [
            PopUpMen(
              menuList: const [
                /*
            PopupMenuItem(child: ListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text('My Profile'),
            )),
            PopupMenuItem(child: ListTile(
              leading: Icon(CupertinoIcons.square_arrow_left),
              title: Text('Log Out'),
            )),
            PopupMenuDivider(),
            PopupMenuItem(child: Text('Settings'))*/
              ],
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF2A3F74),
                  size: 26,
                ),
              ),
            ),
          ],
          backgroundColor: const Color(0xFFFFFFFF),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFF5075A9),
                  size: 27,
                ));
          }),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Set daily limit',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  fontFamily: 'raleway',
                  color: Color(0xFF2A3F74)),
            ),
            //Circular moving slider
            const SizedBox(
              height: 0,
            ),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  startAngle: 0,
                  endAngle: 360,
                  showLabels: false,
                  showTicks: false,
                  radiusFactor: 0.7,
                  axisLineStyle: const AxisLineStyle(
                      cornerStyle: CornerStyle.bothFlat,
                      color: Color(0xFFD6D6D6),
                      thickness: 18),
                  pointers: [
                    RangePointer(
                      value: _volumeValue,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 18,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: Colors.orangeAccent,
                      gradient: const SweepGradient(
                          colors: [Color(0xFF6FADE0), Color(0xFF4483D0)],
                          stops: [0.25, 0.75]),
                    ),
                    //marker type
                    MarkerPointer(
                      enableDragging: true,
                      value: _volumeValue,
                      onValueChanged: onVolumeChanged,
                      markerHeight: 22,
                      markerWidth: 22,
                      markerType: MarkerType.circle,
                      color: const Color(0xFF6FADE0),
                      borderWidth: 2,
                      borderColor: const Color(0xFFFFFFFF),
                    )
                  ],
                  annotations: [
                    GaugeAnnotation(
                        angle: 90,
                        axisValue: 5,
                        positionFactor: 0.1,
                        widget: Text(
                          '${_volumeValue.ceil() * 10} Litres',
                          // _volumeValue.ceil().toString()+'Litres'
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2A3F74),
                          ),
                        ))
                  ],
                )
              ],
            ),
            //set button
            SizedBox(
                width: 234,
                height: 47,
                // ignore: deprecated_member_use
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/graph');
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => SetDailyLimit(volumeValue: _volumeValue,)));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.all(0)),
                    child: Ink(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF6FADE0), Color(0xFF4483D0)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 234, minHeight: 47),
                            alignment: Alignment.center,
                            child: const Text(
                              'SET',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14,
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w600),
                            ))))),
            //wave widget
            const SizedBox(
              height: 88,
            ),
            WaveWidget(
              config: CustomConfig(durations: [
                18000,
                30000,
                60000
              ], heightPercentages: [
                -_volumeValue.ceil() * 0.0044,
                -_volumeValue.ceil() * 0.0074,
                -_volumeValue.ceil() * 0.0054
              ], colors: [
                const Color(0xFFAAD7FB),
                const Color(0xFF94CFFF),
                const Color(0xFFA5D4F9)
              ]),
              size: const Size(double.infinity, 78),
              waveAmplitude: 35,
            )
          ])
        ]));
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: ((context) => menuList),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: icon,
    );
  }
}
