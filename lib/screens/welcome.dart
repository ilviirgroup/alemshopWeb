import 'package:alemadmin/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: HomeScreen(),
          image: Image.asset('images/logo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: MediaQuery.of(context).size.height / 4,
          loaderColor: Colors.red,
        )),
      ),
    );
  }
}
