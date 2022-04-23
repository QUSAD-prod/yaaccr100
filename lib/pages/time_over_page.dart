import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaaccr100/components/background.dart';
import 'package:yaaccr100/pages/question_page.dart';

import '../components/api.dart';

class TimeOverPage extends StatefulWidget {
  const TimeOverPage({Key? key}) : super(key: key);

  @override
  State<TimeOverPage> createState() => _TimeOverPageState();
}

class _TimeOverPageState extends State<TimeOverPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //Фон
          Background(
            width: width,
            height: height,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Панель
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + height * 0.05,
                  ),
                  padding: EdgeInsets.only(
                    left: width * 0.064,
                    right: width * 0.064,
                    top: height * 0.047,
                    bottom: height * 0.045,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: const Offset(0, 1),
                        blurRadius: 3.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        offset: const Offset(0, 12),
                        blurRadius: 28.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/time_over.svg',
                        width: width * 0.18,
                        height: width * 0.18,
                        color: const Color(0xFFE2853A),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.018),
                        child: Text(
                          "Время истекло",
                          style: TextStyle(
                            color: const Color(0xFF0F2E52),
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.032,
                            height: 1.21,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Вы не успели ответить на вопрос в течении 30 секунд, игра была остановлена.",
                          style: TextStyle(
                            color: const Color(0xFF0F2E52).withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.02,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.03),
                        child: Text(
                          "Испытайте удачу еще раз!",
                          style: TextStyle(
                            color: const Color(0xFF0F2E52),
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.02,
                            height: 1.4,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * 0.06,
                    bottom: height * 0.06,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14A75D),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                        color: Colors.black.withOpacity(0.08),
                      ),
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        color: Colors.black.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) => QuestionPage(
                            currentQuestion: 0,
                            questionList: MyApi().getQuestionList(),
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.026,
                            horizontal: width * 0.14,
                          ),
                          width: double.infinity,
                          child: Text(
                            "Попробовать снова",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.025,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
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
