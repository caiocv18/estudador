import 'package:flutter/material.dart';
import 'package:plano_de_estudos/widgets/splashscreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estudador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SplashScreenPage(),
    );
  }
}
