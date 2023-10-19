// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget calcBottom(String btnText, Color btnColor, Color textColor) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: FilledButton(
        onPressed: () {
          calculation(btnText);
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.amber),
            fixedSize: MaterialStatePropertyAll(Size.fromRadius(40))),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
              fontSize: 30, color: Colors.amber, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ////////// calc display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBottom('AC', Colors.grey, Colors.black),
                calcBottom('+/-', Colors.grey, Colors.black),
                calcBottom('%', Colors.grey, Colors.black),
                calcBottom('/', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBottom('7', Colors.grey, Colors.black),
                calcBottom('8', Colors.grey, Colors.black),
                calcBottom('9', Colors.grey, Colors.black),
                calcBottom('x', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBottom('4', Colors.grey, Colors.black),
                calcBottom('5', Colors.grey, Colors.black),
                calcBottom('6', Colors.grey, Colors.black),
                calcBottom('-', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBottom('1', Colors.grey, Colors.black),
                calcBottom('2', Colors.grey, Colors.black),
                calcBottom('3', Colors.grey, Colors.black),
                calcBottom('+', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBottom('0', Colors.grey, Colors.black),
                calcBottom('00', Colors.grey, Colors.black),
                calcBottom('.', Colors.grey, Colors.black),
                calcBottom('=', Colors.amber, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

////////////////////////////////////////////
/////////////////  math  //////////////////
//////////////////////////////////////////
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
