
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:otp_auth/Pages/navdrawer.dart';
// import 'package:intl/intl.dart';

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
      drawer: const NavDrawer(),
      appBar: AppBar(
        /*centerTitle: true,title: DropdownButton(
          items: [DropdownMenuItem(child: Text(DateFormat('d-M-y').format(DateTime.now()),style:
      TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
          color: Color(0xFF2A3F74)),),value: 'one',),
        DropdownMenuItem(child: Text('17 sep 2022',style:
        TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
            color: Color(0xFF2A3F74)),),value: 'two',)], onChanged: (String) {
            setState(() => _value = _value);}),*/
        elevation: 0,
        actions: [
          PopUpMen(
              menuList: const [
                PopupMenuItem(
                    child: ListTile(
                  leading: Icon(CupertinoIcons.person),
                  title: Text('My Profile'),
                )),
                PopupMenuItem(
                    child: ListTile(
                  leading: Icon(CupertinoIcons.square_arrow_left),
                  title: Text('Log Out'),
                )),
                PopupMenuDivider(),
                PopupMenuItem(child: Text('Settings'))
              ],
              icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFFFFFFFF),
                    size: 26,
                  )))
        ],
        backgroundColor: const Color(0xFF72AFDE),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Color(0xFFFFFFFF),
                size: 27,
              ));
        }),
      ),
      resizeToAvoidBottomInset: false,
      body: GridView.count(
        childAspectRatio: 1.1,
        crossAxisCount: 2,
        children: [
          //bathroom utility
          Container(
            margin: const EdgeInsets.only(left: 35, top: 30),
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
                    onToggle: (value) {
                      setState(() {
                        switches = value;
                      });
                    }),
                const Spacer(),
                const Text(
                  '50 Litres',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'inter',
                      color: Color(0xFF000000)),
                )
              ],
            ),
          ),
          //Kitchen utility
          Container(
            margin: const EdgeInsets.only(left: 20, top: 30, right: 30),
            padding: const EdgeInsets.all(30),
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
                const Spacer(),
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
                const Spacer(),
                const Text(
                  '25 Litres',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'inter',
                      color: Color(0xFF000000)),
                )
              ],
            ),
          ),
          //powder Room utility
          Container(
            margin: const EdgeInsets.only(left: 35, top: 30),
            padding: const EdgeInsets.all(30),
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
          Container(
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
          )
        ],
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
