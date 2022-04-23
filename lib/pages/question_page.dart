import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaaccr100/components/background.dart';
import 'package:yaaccr100/components/question_status_widget.dart';
import 'package:yaaccr100/pages/finish_page.dart';
import 'package:yaaccr100/pages/time_over_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
    required this.currentQuestion,
    required this.questionList,
  }) : super(key: key);

  final int currentQuestion;
  final List<Map> questionList;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Widget> questionStatusWidgetList = [];
  int time = 30;
  int? selectedAnswer;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick <= 30) {
          setState(
            () {
              time = time - 1;
            },
          );
        } else {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) => const TimeOverPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    widgetUpdate(width);

    return Scaffold(
      body: Stack(
        children: [
          //Фон
          Background(
            width: width,
            height: height,
          ),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.075),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Реклама
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _launchURL(),
                              child: Image.asset(
                                "assets/banner_1.png",
                                width: width * 0.208,
                              ),
                            ),
                          ),
                          Container(
                            width: 4,
                          ),
                          Image.asset(
                            "assets/banner_2.png",
                            width: width * 0.182,
                          ),
                        ],
                      ),
                    ),
                    //Счётчик
                    getQuestionCounter(height),
                    //Статусы вопросов и ответов
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: height * 0.0025,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: questionStatusWidgetList,
                      ),
                    ),
                    //Текст "Осталось времени для ответа:"
                    Container(
                      margin: EdgeInsets.only(top: height * 0.044),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Осталось времени для ответа:",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.02,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Таймер
                    timerWidget(width, height),
                    //Текст вопроса
                    Container(
                      margin: EdgeInsets.only(top: height * 0.045),
                      child: Text(
                        widget.questionList[widget.currentQuestion]['question']
                            .toString(),
                        style: TextStyle(
                          fontSize: height * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                    ),
                    //Ответы
                    Container(
                      margin: EdgeInsets.only(top: height * 0.005),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getAnswerButton(
                            width,
                            height,
                            widget.questionList[widget.currentQuestion]
                                ['answers'][0],
                            0,
                          ),
                          getAnswerButton(
                            width,
                            height,
                            widget.questionList[widget.currentQuestion]
                                ['answers'][1],
                            1,
                          ),
                          getAnswerButton(
                            width,
                            height,
                            widget.questionList[widget.currentQuestion]
                                ['answers'][2],
                            2,
                          ),
                          getAnswerButton(
                            width,
                            height,
                            widget.questionList[widget.currentQuestion]
                                ['answers'][3],
                            3,
                          ),
                        ],
                      ),
                    ),
                    //Кнопка
                    getButton(height),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL() async {
    String _url = 'https://ulus.media/';
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  void widgetUpdate(double width) {
    questionStatusWidgetList.clear();

    for (int i = 0; i < 30; i++) {
      if (i == widget.currentQuestion) {
        if (selectedAnswer != null) {
          if (widget.questionList[i]['result'] == false) {
            questionStatusWidgetList.add(
              QuestionStatusWidget(
                width: width,
                mode: QuestionStatusWidgetMode.cancel,
              ),
            );
          } else {
            questionStatusWidgetList.add(
              QuestionStatusWidget(
                width: width,
                mode: QuestionStatusWidgetMode.success,
              ),
            );
          }
        } else {
          questionStatusWidgetList.add(
            QuestionStatusWidget(
              width: width,
              mode: QuestionStatusWidgetMode.active,
            ),
          );
        }
      } else if (i > widget.currentQuestion) {
        questionStatusWidgetList.add(
          QuestionStatusWidget(
            width: width,
            mode: QuestionStatusWidgetMode.none,
          ),
        );
      } else if (widget.questionList[i]['result'] == false) {
        questionStatusWidgetList.add(
          QuestionStatusWidget(
            width: width,
            mode: QuestionStatusWidgetMode.cancel,
          ),
        );
      } else {
        questionStatusWidgetList.add(
          QuestionStatusWidget(
            width: width,
            mode: QuestionStatusWidgetMode.success,
          ),
        );
      }
    }
  }

  Widget getQuestionCounter(double height) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Вопрос ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: height * 0.03,
            color: Colors.white,
          ),
        ),
        Text(
          (widget.currentQuestion + 1).toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: height * 0.033,
            color: Colors.white,
            height: 1,
          ),
        ),
        Text(
          "/30",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: height * 0.02,
            color: Colors.white.withOpacity(0.6),
            height: 2,
          ),
        ),
      ],
    );
  }

  Widget timerWidget(double width, double height) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.01),
      height: height * 0.04,
      decoration: BoxDecoration(
        color: const Color(0xFF134A8E),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: time,
                child: Container(
                  margin: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF36A57),
                          Color(0xFFEEA34B),
                          Color(0xFF95DF71),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 30 - time,
                child: Container(),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Container()),
              SizedBox(
                width: width * 0.08,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, height * 0.0013),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/time.svg",
                      color: Colors.white,
                      width: width * 0.045,
                      height: width * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              time.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.02,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, height * 0.0013),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAnswerButton(
    double width,
    double height,
    String answerText,
    int answerId,
  ) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.02),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: selectedAnswer != null
              ? null
              : () => setState(
                    () {
                      timer.cancel();
                      selectedAnswer = answerId;
                      widget.questionList[widget.currentQuestion].addAll(
                        {
                          'result': selectedAnswer ==
                              widget.questionList[widget.currentQuestion]
                                      ['verify'] -
                                  1,
                        },
                      );
                    },
                  ),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.05,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedAnswer != null
                    ? selectedAnswer == answerId
                        ? selectedAnswer ==
                                widget.questionList[widget.currentQuestion]
                                        ['verify'] -
                                    1
                            ? const Color(0xFF14A75D)
                            : const Color(0xFFE04949)
                        : answerId ==
                                widget.questionList[widget.currentQuestion]
                                        ['verify'] -
                                    1
                            ? const Color(0xFF14A75D)
                            : const Color(0xFF7CA7DC)
                    : const Color(0xFF7CA7DC),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
              color: selectedAnswer != null
                  ? selectedAnswer == answerId
                      ? selectedAnswer ==
                              widget.questionList[widget.currentQuestion]
                                      ['verify'] -
                                  1
                          ? const Color(0xFF14A75D)
                          : const Color(0xFFE04949)
                      : answerId ==
                              widget.questionList[widget.currentQuestion]
                                      ['verify'] -
                                  1
                          ? const Color(0xFF14A75D)
                          : Colors.white.withOpacity(0.1)
                  : Colors.white.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    answerText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.018,
                      height: 1.43,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.08,
                ),
                selectedAnswer == null
                    ? Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xFF7CA7DC),
                            width: 2.0,
                          ),
                        ),
                      )
                    : selectedAnswer == answerId
                        ? Container(
                            height: width * 0.064,
                            width: width * 0.064,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: selectedAnswer ==
                                      widget.questionList[widget
                                              .currentQuestion]['verify'] -
                                          1
                                  ? const Color(0xFF0B8547)
                                  : const Color(0xFFB52929),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/check.svg',
                                width: width * 0.035,
                              ),
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getButton(double height) {
    return Container(
      margin: EdgeInsets.only(
        top: height * 0.06,
        bottom: height * 0.06,
      ),
      decoration: BoxDecoration(
        color: selectedAnswer == null
            ? const Color(0xFF127D79)
            : const Color(0xFF14A75D),
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
          onTap: selectedAnswer == null
              ? null
              : widget.currentQuestion < 29
                  ? () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) => QuestionPage(
                            currentQuestion: widget.currentQuestion + 1,
                            questionList: widget.questionList,
                          ),
                        ),
                      )
                  : () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) => FinishPage(
                            questionList: widget.questionList,
                          ),
                        ),
                      ),
          borderRadius: BorderRadius.circular(100),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.026,
              ),
              child: Center(
                child: Text(
                  widget.currentQuestion < 29
                      ? "Следующий вопрос"
                      : "Завершить",
                  style: TextStyle(
                    color: selectedAnswer == null
                        ? const Color(0xFF88A9C9)
                        : Colors.white,
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
    );
  }
}
