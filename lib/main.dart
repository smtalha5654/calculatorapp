import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Simplecalculator(),
    );
  }
}

class Simplecalculator extends StatefulWidget {
  const Simplecalculator({Key? key}) : super(key: key);

  @override
  State<Simplecalculator> createState() => _SimplecalculatorState();
}

class _SimplecalculatorState extends State<Simplecalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildbuton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.white)))),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 30,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(
                    fontSize: equationFontSize, fontWeight: FontWeight.bold),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(
                    fontSize: resultFontSize, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Divider(),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbuton("C", 1, Colors.redAccent),
                      buildbuton("⌫", 1, Colors.red),
                      buildbuton("/", 1, Colors.red)
                    ]),
                    TableRow(children: [
                      buildbuton("7", 1, Colors.grey),
                      buildbuton("8", 1, Colors.grey),
                      buildbuton("9", 1, Colors.grey)
                    ]),
                    TableRow(children: [
                      buildbuton("4", 1, Colors.grey),
                      buildbuton("5", 1, Colors.grey),
                      buildbuton("6", 1, Colors.grey)
                    ]),
                    TableRow(children: [
                      buildbuton("1", 1, Colors.grey),
                      buildbuton("2", 1, Colors.grey),
                      buildbuton("3", 1, Colors.grey)
                    ]),
                    TableRow(children: [
                      buildbuton(".", 1, Colors.grey),
                      buildbuton("0", 1, Colors.grey),
                      buildbuton("00", 1, Colors.grey)
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbuton("*", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildbuton("-", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildbuton("+", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildbuton("=", 2, Colors.grey),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
