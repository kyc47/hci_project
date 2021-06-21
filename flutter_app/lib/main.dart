import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  late Timer _timer2;
  int _start = 12;
  int _startTest = 20;
  bool actTime = false;
  bool testDo = false;

  void startTimer() {
    _timer = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        print(_start);
        if (_start < 1) {
          setState(() {
            actTime = false;
            timer.cancel();
          });
        } else if(_start < 4 && _start > 2) {
          setState(() {
            actTime = true;
          });
          _start = _start - 1;
        }else{
          _start = _start - 1;
        }
      },
    );

    _timer2 = new Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
          if(_startTest<1){
            timer.cancel();
            setState(() {
              testDo = true;
            });
          }else{
            _startTest = _startTest - 1;
          }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            actTime
                ? Container(
                    decoration: BoxDecoration(color: Colors.green),
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                  )
                : SizedBox(),
            testDo
                ? Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () {
                            setState(() {
                              testDo = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: () {
                            setState(() {
                              testDo = false;
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue)),
                          onPressed: () {
                            setState(() {
                              testDo = false;
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          )),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timer2.cancel();
  }
}
