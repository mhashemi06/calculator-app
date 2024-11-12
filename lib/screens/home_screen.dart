import 'package:calculator/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputUser = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: backgroundGreyDark,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    inputUser,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 28,
                        color: textGreen,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    result,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 45,
                        color: textGreen,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
                color: backgroundGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRow('ac', 'ce', '%', '/'),
                    getRow('7', '8', '9', '*'),
                    getRow('4', '5', '6', '-'),
                    getRow('1', '2', '3', '+'),
                    getRow('00', '0', '.', '='),
                  ],
                )),
          ),
        ],
      )),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text1),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              acButtonOnPressed();
            } else {
              buttonOnPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: getFontSize(text1),
                color: getTextColor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              ceButtonOnPressed();
            } else {
              buttonOnPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: getFontSize(text2),
                color: getTextColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonOnPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              style: TextStyle(
                fontSize: getFontSize(text3),
                color: getTextColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              finalCalculate();
            } else {
              buttonOnPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              style: TextStyle(
                fontSize: getFontSize(text4),
                color: getTextColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///=================== Colors & fontSize operation ===================
  bool ioOperator(String text) {
    List list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (ioOperator(text)) {
      return backgroundGreyDark;
    }
    return backgroundGrey;
  }

  Color getTextColor(String text) {
    if (ioOperator(text)) {
      return textGreen;
    }
    return textGrey;
  }

  double getFontSize(String text) {
    if (ioOperator(text)) {
      return 28.0;
    }
    return 26.0;
  }

  ///=================== Display the content of the button clicked by the user ===================
  void buttonOnPressed(String text) {
    setState(() {
      inputUser += text;
    });
  }

  ///=================== ac button Function (ac) ===================
  void acButtonOnPressed() {
    setState(() {
      inputUser = '';
      result = '';
    });
  }

  ///=================== ce button Function (ce) ===================
  void ceButtonOnPressed() {
    setState(() {
      if (inputUser.length != 0) {
        inputUser = inputUser.substring(0, inputUser.length - 1);
      }
    });
  }

  ///=================== Final calculation (=) ===================
  void finalCalculate() {
    Parser parser = Parser();
    var expression = parser.parse(inputUser);
    ContextModel contextModel = ContextModel();

    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    if (eval.truncateToDouble() == eval) {
      int resultInt = eval.toInt();
      setState(() {
        result = resultInt.toString();
      });
    } else {
      setState(() {
        result = eval.toString();
      });
    }
  }
}
