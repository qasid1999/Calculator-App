import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Container container(double heightofcontainer, double widthofcontainer,
      Color colors, Widget child) {
    return Container(
        height: heightofcontainer,
        width: widthofcontainer,
        color: colors,
        child: child);
  }

  Widget row(String text1, String text2, String text3, String text4) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      circleAvetar(text1),
      circleAvetar(text2),
      circleAvetar(text3),
      circleAvetar(text4),
    ]);
  }

  var inputExpression = "";

  clear() {
    setState(() {
      inputExpression = '';
    });
  }

  var result = '';
  output() {
    setState(() {
      Parser prs = Parser();
      Expression exp = prs.parse(inputExpression);
      ContextModel mdl = ContextModel();
      double evel = exp.evaluate(EvaluationType.REAL, mdl);

      result = evel.toString();
    });
  }

  CircleAvatar circleAvetar(var text) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 35,
      child: TextButton(
        onPressed: () {
          try {
            if (text != 'C' && text != '=') {
              setState(
                () {
                  inputExpression = inputExpression + text;
                },
              );
            } else if (text == "=") {
              output();
            } else if (text == 'C') {
              clear();
            }
          } catch (e) {
            setState(() {
              inputExpression = 'Error';
            });
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            container(
              200.0,
              double.infinity,
              Colors.teal[100],
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '= $result',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      '$inputExpression',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: container(
              null,
              double.infinity,
              Colors.grey[300],
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  row('7', '8', '9', '*'),
                  row('4', '5', '6', '/'),
                  row('1', '2', '3', '+'),
                  row('=', '0', 'C', '-'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
