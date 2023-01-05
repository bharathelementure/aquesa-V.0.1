import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/authPage.dart';
import 'package:otp_auth/Pages/siginInPage.dart';
import 'package:otp_auth/Pages/verifyemailPage.dart';
import 'package:otp_auth/circularSetDailyLimit.dart';
import 'package:otp_auth/darkOTP.dart';
import 'package:otp_auth/home.dart';
import 'package:otp_auth/nameDevice.dart';
import 'package:otp_auth/notifications.dart';
import 'package:otp_auth/otpVerifications.dart.dart';
import 'package:otp_auth/ownerUtility.dart';
import 'package:otp_auth/payment&invoices.dart';
import 'package:otp_auth/qrCodeScanner.dart';
import 'package:otp_auth/registration.dart';
import 'package:otp_auth/splashScreen.dart';
import 'package:otp_auth/thank_You.dart';
import 'package:otp_auth/utility.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(MaterialApp(
    initialRoute: '/SplashScreen',
    debugShowCheckedModeBanner: false,
    routes: {
      '/SplashScreen': (context) => const SplashScreen(),
      '/Graph': (context) => const Graph(),
      '/verifyemailPage':(context) => const VerifyEmailPage(),
      '/Registration': (context) => const Registration(),
      '/OTPVerification': (context) => const MyVerify(),
      '/darkOTP': (context) => const DarkOTP(),
      '/circularsetDailyLimit': (context) => const CircularSetDailyLimit(),
      '/utility': (context) => const Utility(),
      '/ownerutility': (context) => const OwnerUtility(),
      '/nameDevice': (context) => const NameDevice(),
      '/paymentsInvoices': (context) => const PaymentInvoices(),
      '/notifications': (context) => const Notifications(),
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
            }else {
              return const AuthPage();
            }
          }),
    );
  }
}
