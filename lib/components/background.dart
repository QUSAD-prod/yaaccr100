import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Фон
        SizedBox(
          width: width,
          height: height,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset("assets/background.png"),
          ),
        ),
        //Затенение фона
        Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1F619E).withOpacity(0),
                      const Color(0xFF0F5495).withOpacity(0.9),
                    ],
                    stops: const [0, 0.4427],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
