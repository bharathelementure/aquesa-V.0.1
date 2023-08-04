import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Utility extends StatefulWidget {
  const Utility({Key? key}) : super(key: key);

  @override
  State<Utility> createState() => _UtilityState();
}

class _UtilityState extends State<Utility> {
  bool switches = false;
  bool switches1 = false;
  bool switches2 = false;
  bool switches3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72AFDE),
      // drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF72AFDE),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: GridView.count(
        childAspectRatio: 1.1,
        crossAxisCount: 2,
        children: [
          //bathroom utility
          Container(
            margin: const EdgeInsets.only(left: 45, top: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                const Text(
                  'Bathroom',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF000000)),
                ),
                const Spacer(),
                FlutterSwitch(
                    width: 52,
                    height: 23,
                    activeColor: const Color(0xFF59B8EE),
                    inactiveColor: const Color(0xFFD2D2D2),
                    toggleColor: const Color(0xFFFFFFFF),
                    toggleSize: 21,
                    value: switches,
                    onToggle: (value) async {
                      await Future.delayed(Duration(minutes: 1));
                      setState(() {
                        switches = value;
                        print(value);
                      });
                    }),
                const Spacer(),
                // const Text(
                //   '50 Litres',
                //   style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.w300,
                //       fontFamily: 'inter',
                //       color: Color(0xFF000000)),
                // )
              ],
            ),
          ),
          //Kitchen utility
          Container(
            margin: const EdgeInsets.only(left: 20, top: 30, right: 30),
            padding: const EdgeInsets.all(27),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                const Text(
                  'Kitchen',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF000000)),
                ),
                const SizedBox(
                  height: 20,
                ),
                FlutterSwitch(
                    width: 52,
                    height: 23,
                    activeColor: const Color(0xFF59B8EE),
                    inactiveColor: const Color(0xFFD2D2D2),
                    toggleColor: const Color(0xFFFFFFFF),
                    toggleSize: 21,
                    value: switches1,
                    onToggle: (value) {
                      setState(() {
                        switches1 = value;
                      });
                    }),
                // Spacer(),
                // Text('data')
              ],
            ),
          ),
          //powder Room utility
          Container(
            margin: const EdgeInsets.only(left: 45, top: 30),
            padding: const EdgeInsets.all(27),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                const Text(
                  'Powder Room',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF000000)),
                ),
                const SizedBox(
                  height: 20,
                ),
                FlutterSwitch(
                    width: 52,
                    height: 23,
                    activeColor: const Color(0xFF59B8EE),
                    inactiveColor: const Color(0xFFD2D2D2),
                    toggleColor: const Color(0xFFFFFFFF),
                    toggleSize: 21,
                    value: switches2,
                    onToggle: (value) {
                      setState(() {
                        switches2 = value;
                      });
                    })
              ],
            ),
          ),
          //Utility
          Container(
            margin: const EdgeInsets.only(left: 20, top: 30, right: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                const Text(
                  'Utility',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF000000)),
                ),
                const SizedBox(
                  height: 20,
                ),
                FlutterSwitch(
                    width: 52,
                    height: 23,
                    activeColor: const Color(0xFF59B8EE),
                    inactiveColor: const Color(0xFFD2D2D2),
                    toggleColor: const Color(0xFFFFFFFF),
                    toggleSize: 21,
                    value: switches3,
                    onToggle: (value) {
                      setState(() {
                        switches3 = value;
                      });
                    })
              ],
            ),
          ),
          //add utility
          /*Container(
            margin: const EdgeInsets.only(left: 35, top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(25)),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ownerutility');
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xFF2A3F74),
                      size: 83,
                    ))
              ],
            ),
          )*/
        ],
      ),
    );
  }
}
