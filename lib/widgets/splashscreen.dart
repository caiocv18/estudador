import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

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
        AnimatedSplashScreen(
            duration: 5000,
            splash: Icons.home,
            nextScreen: HomePage(title: "Estudador"),
            backgroundColor: Colors.blue),
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
