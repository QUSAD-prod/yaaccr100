import 'package:flutter/material.dart';
import 'package:yaaccr100/components/background.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Background(
            width: width,
            height: height,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container()),
                      Image.asset(
                        "assets/banner_1.png",
                        width: width * 0.208,
                      ),
                      Image.asset(
                        "assets/banner_2.png",
                        width: width * 0.182,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
