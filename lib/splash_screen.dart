import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_flutter_sample_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      _goToNextScreen();
    });
    super.initState();
  }

  void _goToNextScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return _hasLogin
          ? HomeScreen(hasLogin: true, key: CallNavigationContext.navigatorKey)
          : const Login();
    }));
  }

  bool get _hasLogin {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/cometchat_logo.png', height: 80)),
            const SizedBox(height: 19),
            Text(
              Strings.appName,
              style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
