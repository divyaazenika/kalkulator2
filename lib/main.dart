import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
         textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)) ,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}
 
 class Calculator extends StatefulWidget{
  @override
    _CalculatorState createState()=> _CalculatorState();
 }
class _CalculatorState extends State<Calculator>{
  String Output = "0";

  void buttonPressed (String buttonText){
   setState(() {
      if (buttonText== "C") {Output = "0";} 
       else if (buttonText == "="){
        try{Output=evaluateExpression(Output);}catch(e){
          Output="error";
        }
       }
       else{
        if (Output == '0') {
          Output =buttonText;
        }
        else {
          Output += buttonText;
        }
       }
    });
  
  }
  String evaluateExpression(String expression){
    final parsedExpression = Expression.parse(expression);
    final evalutor = ExpressionEvaluator();
    final result =evalutor.eval(parsedExpression,{});
    return result.toString();
  }

Widget buildButton(String buttonText, Color color,
      {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 22),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
 @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: 24,
                bottom: 24),
                alignment: Alignment.bottomRight,
                child: Text(Output,
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                buildButton("C", Colors.grey.shade600),
                buildButton("&", Colors.grey.shade600),
                buildButton("%", Colors.grey.shade600),
                buildButton("/", Colors.orange),
                ]
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade900),
                  buildButton("8", Colors.grey.shade900),
                  buildButton("9", Colors.grey.shade900),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade900),
                  buildButton("5", Colors.grey.shade900),
                  buildButton("6", Colors.grey.shade900),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade900),
                  buildButton("2", Colors.grey.shade900),
                  buildButton("3", Colors.grey.shade900),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", Colors.grey.shade900, widthFactor: 2.0),
                  buildButton(".", Colors.grey.shade900),
                  buildButton("=", Colors.orange),
                ],
              )
            ],

          )
        ],
      ),
    );
  }
}