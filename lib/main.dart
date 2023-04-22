import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/authPage.dart';
import 'package:otp_auth/Pages/edit_update.dart';
import 'package:otp_auth/Pages/verifyemailPage.dart';
import 'package:otp_auth/circularSetDailyLimit.dart';
import 'package:otp_auth/darkOTP.dart';
import 'package:otp_auth/home.dart';
import 'package:otp_auth/qrCodeScanner.dart';
import 'package:otp_auth/registration.dart';
import 'package:otp_auth/setDilyLimit.dart';
import 'package:otp_auth/splashScreen.dart';
import 'package:otp_auth/thank_You.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

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
      '/darkOTP': (context) => const DarkOTP(),
      '/circularsetDailyLimit': (context) => const CircularSetDailyLimit(),
      '/edit_update': (context) => const EditUpdate(),
      '/setDaily': (context) => const SetDailyLimit(),
      '/graph': (context) => const Graph(),
      '/qrCodeScanner': (context) => const QrCodeScanner(),
      '/thank_you': (context) => const ThankYou(),
    },
  ));
}

class Intializer extends StatefulWidget {
  const Intializer({super.key});

  @override
  State<Intializer> createState() => _IntializerState();
}

class _IntializerState extends State<Intializer> {
  late FirebaseAuth _auth;
  User? _user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
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
