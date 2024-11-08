import 'package:flutter/material.dart';
import 'package:go2code_ad_02/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCADCFC),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 20))),
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: Container(
                  child: Center(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.green,
                              textColor: Colors.white,
                            );
                          } else if (index == 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                          else if (index == buttons.length - 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equlPressed();
                                });
                              },
                              buttonText: buttons[index],
                              color: Color(0xff00246B),
                              textColor: Colors.white,
                            );
                          } 
                           else {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])
                                  ? Color(0xff00246B)
                                  : Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Color(0xff00246B),
                            );
                          }
                        }),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '-' || x == '+' || x == 'x' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equlPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
