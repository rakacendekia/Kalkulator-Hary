import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Kalkulator());
}

class Kalkulator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        //backgroundColor: Colors.white10,
      ),
      home: KalkulatorSederhana(),
    );
  }
}

class KalkulatorSederhana extends StatefulWidget {
  @override
  _KalkulatorSederhanaState createState() => _KalkulatorSederhanaState();
}

class _KalkulatorSederhanaState extends State<KalkulatorSederhana> {
  String awal = "";
  String hasil = "";
  String nilai = "";
  double SizeAwal = 25.0;
  double SizeHasil = 35.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        awal = "";
        hasil = "";
        SizeAwal = 25.0;
        SizeHasil = 35.0;
      } else if (buttonText == "?") {
        SizeAwal = 25.0;
        SizeHasil = 35.0;
        awal = awal.substring(0, awal.length - 1);
        if (awal == "") {
          awal = "0";
        }
      } else if (buttonText == "=") {
        SizeAwal = 25.0;
        SizeHasil = 35.0;

        nilai = awal;
        nilai = nilai.replaceAll('×', '*');
        nilai = nilai.replaceAll('÷', '/');
        nilai = nilai.replaceAll('%', '/100');

        try {
          Parser p = Parser();
          Expression exp = p.parse(nilai);

          ContextModel cm = ContextModel();
          hasil = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          hasil = "Error";
        }
      } else {
        SizeAwal = 25.0;
        SizeHasil = 35.0;
        if (awal == "0") {
          awal = buttonText;
        } else {
          awal = awal + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.122 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.5),
              side: BorderSide(
                  color: Colors.white, width: 0.3, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              awal,
              style: TextStyle(fontSize: SizeAwal),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              hasil,
              style: TextStyle(fontSize: SizeHasil),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.transparent),
                      buildButton("?", 1, Colors.transparent),
                      buildButton("%", 1, Colors.transparent),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black45),
                      buildButton("5", 1, Colors.black45),
                      buildButton("6", 1, Colors.black45),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black38),
                      buildButton("2", 1, Colors.black38),
                      buildButton("3", 1, Colors.black38),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black26),
                      buildButton("0", 1, Colors.black26),
                      buildButton("00", 1, Colors.black26),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("÷", 1, Colors.transparent),
                    ]),
                    TableRow(children: [
                      buildButton("×", 1, Colors.transparent),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.transparent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.transparent),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.transparent),
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
