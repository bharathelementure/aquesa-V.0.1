import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_auth/Pages/authPage.dart';
import 'package:otp_auth/Pages/edit_update.dart';
import 'package:otp_auth/Pages/verifyemailPage.dart';
import 'package:otp_auth/Screens/circularSetDailyLimit.dart';
import 'package:otp_auth/Screens/home.dart';
import 'package:otp_auth/Screens/qrCodeScanner.dart';
import 'package:otp_auth/Screens/registration.dart';
import 'package:otp_auth/Screens/setDilyLimit.dart';
import 'package:otp_auth/Screens/splashScreen.dart';
import 'package:otp_auth/Screens/utility_valve_control.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    initialRoute: '/SplashScreen',
    debugShowCheckedModeBanner: false,
    // defaultTransition: Transition.leftToRightWithFade,
    // transitionDuration: const Duration(microseconds: 300),
    // theme: ThemeData(useMaterial3: true),
    routes: {
      '/SplashScreen': (context) => const SplashScreen(),
      '/Graph': (context) => const Graph(),
      '/verifyemailPage': (context) => const VerifyEmailPage(),
      '/Registration': (context) => const Registration(),
      '/circularsetDailyLimit': (context) => const CircularSetDailyLimit(),
      '/edit_update': (context) => const EditUpdate(),
      '/setDaily': (context) => const SetDailyLimit(),
      '/graph': (context) => const Graph(),
      '/qrCodeScanner': (context) => const QrCodeScanner(),
      '/utility_valve_controller': (context) => const Utility(),
    },
  ));
}

class Intializer extends StatefulWidget {
  const Intializer({super.key});

  @override
  State<Intializer> createState() => _IntializerState();
}

class _IntializerState extends State<Intializer> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  /*@override
  Widget build(BuildContext context) {
    return isLoading? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : _user == null ? const VerifyEmailPage() : const Graph();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailPage();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
