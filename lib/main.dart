import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaaccr100/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        splashFactory: InkRipple.splashFactory,
      ),
      home: const StartPage(),
    );
  }
}
