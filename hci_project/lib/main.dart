//  @dart=2.9

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HCI Project',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HCI Project Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: FittedBox(
                child: Text("ID"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PlayPage()));
        },
      ),
    );
  }
}

class PlayPage extends StatefulWidget {
  const PlayPage({Key key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool actTime = false;
  bool testDo = false;

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'video/lec1.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play().then((value) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);

      // Timer(Duration(minutes: 8), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });
      // Timer(Duration(minutes: 16), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });
      // Timer(Duration(minutes: 30), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });
      // Timer(Duration(minutes: 36), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });
      // Timer(Duration(minutes: 55), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });
      // Timer(Duration(minutes: 63), () {
      //   print("Yeah, this line is printed after 3 seconds");
      // });

      Timer(Duration(seconds: 10), () {
        testDo = true;
      });
      Timer(Duration(seconds: 13), () {
        testDo = false;
      });
    });
    super.initState();
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  int check = 0;
  bool displayButton = false;
  List<int> temp = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(
              padding: EdgeInsets.only(top: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 160,
              alignment: Alignment.topRight,
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  return !testDo
                      ? SizedBox(
                    width: MediaQuery.of(context).size.width*0.1,
                    child:  ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.check),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),

                      ),
                      label: Text("ElevatedButton.icon"),
                    ),
                  )
                      : Text(StopWatchTimer.getDisplayTimeSecond(value));
                },
              ))
        ],
      ),
    );
  }
}
