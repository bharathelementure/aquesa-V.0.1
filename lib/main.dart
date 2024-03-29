import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_auth/Pages/auth_page.dart';
import 'package:otp_auth/Pages/edit_update.dart';
import 'package:otp_auth/Pages/verify_email_page.dart';
import 'package:otp_auth/Screens/circular_set_daily_limit.dart';
import 'package:otp_auth/Screens/home.dart';
import 'package:otp_auth/Screens/qr_code_scanner.dart';
import 'package:otp_auth/Screens/registration.dart';
import 'package:otp_auth/Screens/set_daily_limit.dart';
import 'package:otp_auth/Screens/splash_screen.dart';
import 'package:otp_auth/Screens/utility_valve_control.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
