// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

// String? stringResponse;

class SetDailyLimit extends StatefulWidget {
  // final volumeValue;
  const SetDailyLimit({
    Key? key,
  }) : super(key: key);

  @override
  State<SetDailyLimit> createState() => _SetDailyLimitState();
}

String? stringResponse;

class _SetDailyLimitState extends State<SetDailyLimit> {
  Future apiConsumption() async {
    http.Response response;
    response =
        await http.post(Uri.parse("http://192.168.0.116:8000/watermeter"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    apiConsumption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A70A1),
      // drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A70A1),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFFFFFFFF),
                size: 26,
              ))
        ],
      ),
      /*appBar: AppBar(
        centerTitle: true,
        //drop down items
        /*title: DropdownButton(items:
      [DropdownMenuItem(child: Text('16 sep 2022',style:
      TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
          color: Color(0xFF2A3F74)),),value: 'one',),
        DropdownMenuItem(child: Text('17 sep 2022',style:
        TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
            color: Color(0xFF2A3F74)),),value: 'two',)],
          onChanged: (String ) {setState(() => _value = _value);},),*/
        elevation: 0,
        actions: [
          PopUpMen(
              menuList: const [
                /*PopupMenuItem(child: ListTile(
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
                  )))
        ],
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF5075A9),
                size: 27,
              ),
            );
          },
        ),
      ),*/
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*WaveWidget(
                config: CustomConfig(durations: [
                  18000,
                  30000,
                  60000
                ], heightPercentages: [
                  0.65,
                  0.66,
                  0.68
                ], colors: [
                  Color(0xFFAAD7FB),
                  Color(0xFF94CFFF),
                  Color(0xFFA5D4F9)
                ]),
                size: Size(double.infinity, 200),
                waveAmplitude: 35,
                backgroundColor: Color(0xFFFFFFFF),
              ),*/
              const SizedBox(
                height: 36,
              ),
              const Text(
                "Today's Consumption",
                style: TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF)),
              ),
              const SizedBox(
                height: 42,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '69.7',
                            // stringResponse.toString(),
                            // widget.volumeValue.ceil().toString(),
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 100,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),
                          ),
                          /* const Text(
                            '%',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 50,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)),
                          ),*/
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 0,
              ),
              const Text(
                'Litres',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    fontFamily: 'raleway',
                    color: Color(0xFFFFFFFF)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 234,
                  height: 47,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        var navi = await Navigator.pushNamed(
                            context, '/circularsetDailyLimit');
                        if (navi == true || navi == null) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/graph', (Route<dynamic> route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.all(0)),
                      child: Ink(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF6FADE0),
                                Color(0xFF4483D0)
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 234, minHeight: 47),
                              alignment: Alignment.center,
                              child: const Text(
                                'RESET LIMIT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w600),
                              ))))),
              const SizedBox(
                height: 121,
              ),
              WaveWidget(
                config: CustomConfig(durations: [
                  18000,
                  30000,
                  60000
                ], heightPercentages: [
                  0.0064,
                  0.0074,
                  0.0084
                  /*-widget.volumeValue * 0.0064,
                  -widget.volumeValue * 0.0074,
                  -widget.volumeValue * 0.0084*/
                ], colors: [
                  const Color(0xFFAAD7FB),
                  const Color(0xFF94CFFF),
                  const Color(0xFFA5D4F9)
                ]),
                size: const Size(double.infinity, 128),
                waveAmplitude: 35,
                backgroundColor: const Color(0xFF3A70A1),
              ),
            ],
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
