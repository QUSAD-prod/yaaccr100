import 'package:flutter/material.dart';

enum QuestionStatusWidgetMode { none, cancel, success, active }

class QuestionStatusWidget extends StatelessWidget {
  const QuestionStatusWidget({
    Key? key,
    required this.width,
    required this.mode,
  }) : super(key: key);
  final double width;
  final QuestionStatusWidgetMode mode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.0027),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Color getColor() {
    switch (mode) {
      case QuestionStatusWidgetMode.none:
        return const Color(0xFF134A8E);
      case QuestionStatusWidgetMode.cancel:
        return const Color(0xFFE04949);
      case QuestionStatusWidgetMode.success:
        return const Color(0xFF14A75D);
      case QuestionStatusWidgetMode.active:
        return const Color(0xFFFFFFFF);
    }
  }
}
