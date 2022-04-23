import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaaccr100/pages/question_page.dart';
import 'package:yaaccr100/pages/sertificate_sent_page.dart';

import '../components/api.dart';
import '../components/background.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({
    Key? key,
    required this.questionList,
  }) : super(key: key);

  final List<Map> questionList;

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  int count = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nameFocus = FocusNode(debugLabel: 'nameFocus');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'emailFocus');

  String name = "";
  String email = "";
  bool isValid = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(
      () => name = _nameController.text,
    );
    _emailController.addListener(
      () => {
        email = _emailController.text,
        isValid = EmailValidator.validate(email),
      },
    );

    for (int i = 0; i < 30; i++) {
      if (widget.questionList[i]['result'] == true) {
        count++;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      _scrollController.jumpTo(MediaQuery.of(context).viewInsets.bottom);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //Фон
          Background(
            width: width,
            height: height,
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              controller: _scrollController,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.075),
                  child: Column(
                    children: [
                      //Кол-во правильных ответов
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.05,
                        ),
                        width: double.infinity,
                        height: height * 0.23,
                        decoration: BoxDecoration(
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
                          image: const DecorationImage(
                            image: ExactAssetImage('assets/back_finish.png'),
                            fit: BoxFit.cover,
                            opacity: 0.9,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                count.toString(),
                                style: TextStyle(
                                  color: const Color(0xFF14A75D),
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.08,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                getFirstString(count),
                                style: TextStyle(
                                  color: const Color(0xFF0F2E52),
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.025,
                                  height: 1.21,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Сравнение правильных ответов с ошибками
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
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
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF14A75D),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: count,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 30 - count,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE04949),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    count.toString() + " правильно",
                                    style: TextStyle(
                                      color: const Color(0xFF14A75D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.0155,
                                      height: 1.4,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    (30 - count).toString() +
                                        getSecondString(30 - count),
                                    style: TextStyle(
                                      color: const Color(0xFFE04949),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.0155,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Поля для сертификата
                      Container(
                        margin: EdgeInsets.only(top: height * 0.1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Получите сертификат\n(в течение 24ч)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: height * 0.028,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: getField(
                                "Ваше имя",
                                "Смирнов Михаил",
                                _nameController,
                                TextInputType.name,
                                TextInputAction.next,
                                _nameFocus,
                                [
                                  AutofillHints.name,
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: getField(
                                "Ваш Email",
                                "Example@mail.ru",
                                _emailController,
                                TextInputType.emailAddress,
                                TextInputAction.done,
                                _emailFocus,
                                [
                                  AutofillHints.email,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Кнопка получить сертификат
                      Container(
                        margin: EdgeInsets.only(top: height * 0.05),
                        decoration: BoxDecoration(
                          color: name != "" && email != "" && isValid
                              ? const Color(0xFF14A75D)
                              : const Color(0xFF127D79),
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
                            onTap: name != "" && email != "" && isValid
                                ? () => send()
                                : null,
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
                                  "Получить сертификат",
                                  style: TextStyle(
                                    color: name != "" && email != "" && isValid
                                        ? Colors.white
                                        : const Color(0xFF88A9C9),
                                    fontWeight: FontWeight.w700,
                                    fontSize: height * 0.022,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      //Кнопка пройти викторину повторно
                      Container(
                        margin: EdgeInsets.only(
                          top: 8,
                          bottom: height * 0.03,
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
                                  horizontal: width * 0.1,
                                ),
                                width: double.infinity,
                                child: Text(
                                  "Пройти викторину повторно",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: height * 0.022,
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
          ),
        ],
      ),
    );
  }

  String getFirstString(int count) {
    switch (count) {
      case 1:
      case 21:
        return 'Правильный\nответ';
      case 2:
      case 3:
      case 4:
      case 22:
      case 23:
      case 24:
        return 'Правильных\nответа';
      default:
        return 'Правильных\nответов';
    }
  }

  String getSecondString(int count) {
    switch (count) {
      case 1:
      case 21:
        return ' ошибка';
      case 2:
      case 3:
      case 4:
      case 22:
      case 23:
      case 24:
        return ' ошибки';
      default:
        return ' ошибок';
    }
  }

  Widget getField(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    FocusNode focusNode,
    Iterable<String> autofillHints,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            controller: controller,
            autofillHints: autofillHints,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            cursorColor: Colors.white,
            cursorRadius: const Radius.circular(5),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              fillColor: Colors.white.withOpacity(0.1),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 18,
              ),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF7CA7DC),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF7CA7DC),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF7CA7DC),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void send() async {
    DateTime date = DateTime.now();

    DatabaseReference ref = FirebaseDatabase.instance.ref().child(
          date.day.toString() +
              '-' +
              date.month.toString() +
              '-' +
              date.year.toString(),
        );

    String result = '';

    ConnectivityResult internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.mobile ||
        internet == ConnectivityResult.wifi) {
      try {
        await ref.push().set(
          {
            'name': name,
            'email': email,
            'result': count,
          },
        );
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    } else {
      result = 'network-request-failed';
    }

    switch (result) {
      case 'success':
        showSnackBar(
          context: context,
          text: "Запрос на сертификат успешно отправлен",
          icon: SvgPicture.asset(
            "assets/icon_done.svg",
            color: const Color(0xFF4BB34B),
          ),
        );
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => const SertificateSentPage(),
          ),
        );
        break;
      case 'network-request-failed':
        showSnackBar(
          text: "Нет подключения к интернету",
          icon: SvgPicture.asset(
            "assets/icon_globe_cross_outline.svg",
            color: const Color(0xFFE64646),
          ),
          context: context,
        );
        break;
      default:
        showSnackBar(
          text: "Неизвестная ошибка",
          icon: SvgPicture.asset(
            "assets/icon_cancel.svg",
            color: const Color(0xFFE64646),
          ),
          context: context,
        );
    }
  }
}

showSnackBar({
  required String text,
  Widget? icon,
  required BuildContext context,
}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: icon == null
        ? const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          )
        : const EdgeInsets.only(
            left: 12.0,
            right: 16.0,
            top: 12.0,
            bottom: 12.0,
          ),
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 12.0,
    ),
    content: Row(
      children: [
        Container(
          margin: icon == null
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.only(right: 12.0),
          child: icon ?? const SizedBox(width: 0, height: 0),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
