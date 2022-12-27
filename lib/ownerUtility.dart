
import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class OwnerUtility extends StatefulWidget {
  const OwnerUtility({Key? key}) : super(key: key);

  @override
  State<OwnerUtility> createState() => _OwnerUtilityState();
}

class _OwnerUtilityState extends State<OwnerUtility> {
  int count = 10;

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
              child: Icon(Icons.account_circle),
            )
          ],
        ),
      ),
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Owner',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            fontFamily: 'raleway',
            color: Color(0xFFFFFFFF),
          ),
        ),
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
                  height: 0,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.all(15),
                    height: 78,
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
                              'Add House',
                              style: TextStyle(
                                  fontFamily: 'raleway',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Color(0xFF2A3F74)),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Name your house',
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
                            Navigator.pushNamed(context, '/nameDevice');
                          },
                          backgroundColor: const Color(0xFF2A3F74),
                          child: const Icon(
                            Icons.add,
                            color:  Color(0xFFFFFFFF),
                            size: 50,
                          ),
                        )
                      ],
                    )),
                //second bar
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(8),
                  height: 113,
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
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'House 1',
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
                            'Set limit',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                color: Color(0xFF2A3F74)),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Remove',
                                style: TextStyle(
                                    fontFamily: 'raleway',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color:  Color(0xFF4483D0)),
                              )),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count--;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.horizontal_rule,
                                    color: Color(0xFF2A3F74),
                                    size: 17,
                                  )),
                              const SizedBox(
                                height: 0,
                              ),
                              Text(
                                '$count Litres',
                                style: const TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xFF2A3F74)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count = count + 10;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color(0xFF2A3F74),
                                    size: 17,
                                  ))
                            ],
                          )
                        ],
                      )
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
                        'House 2',
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
                            'Edit',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                fontSize: 12,
                                color: Color(0xFF4483D0)),
                          )),
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
                //Fourth bar
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
                        'House 3',
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
                            'Edit',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                fontSize: 12,
                                color:  Color(0xFF4483D0)),
                          )),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                fontSize: 12,
                                color:  Color(0xFF4483D0)),
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
                        'House 4',
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
                            'Edit',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'raleway',
                                fontSize: 12,
                                color: Color(0xFF4483D0)),
                          )),
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
              ],
            )
          ],
        ),
      ),
    );
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
