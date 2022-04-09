import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaaccr100/pages/question_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //Фон
          SizedBox(
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset("assets/start_page_background.png"),
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
                        const Color(0xFF094B88).withOpacity(0),
                        const Color(0xFF094B88).withOpacity(0.8),
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
          //Логотип
          Container(
            margin: EdgeInsets.only(top: height * 0.2, bottom: height * 0.52),
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                color: Colors.white,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              SizedBox(
                width: width,
                child: Text(
                  "Прими участие",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: height * 0.0375,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Ответь верно на все поставленные\nвопросы и получи сертификат",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: height * 0.0225,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              //Кнопка
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
                        builder: (BuildContext context) => const QuestionPage(),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(100),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.026,
                          horizontal: width * 0.19,
                        ),
                        child: Text(
                          "Начать викторину",
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
        ],
      ),
    );
  }
}
