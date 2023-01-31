import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class SplashScreenPage extends StatefulWidget {

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          backgroundColor: Colors.white,
          navigateAfterSeconds: const HomePage(title: 'Estudador'),
          loaderColor: Colors.transparent,
        ),
        Align(
          alignment: FractionalOffset.center,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icon.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
            width: MediaQuery.of(context).size.width / 4,
          ),
        ),
      ],
    );
  }
}
