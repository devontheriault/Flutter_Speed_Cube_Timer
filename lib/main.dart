import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController tb;

  @override
  void initState(){
    tb = TabController(
      length: 2,
      vsync: this, 
    );
    super.initState();
  }

  //stopwatch
  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String stopTimeToDtisplay = "00:00:00";
  var sWatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void startTimer(){
    Timer(dur,keepRunning);
  }

  void keepRunning(){
    if(sWatch.isRunning){
      startTimer();
    }
    setState(() {
      stopTimeToDtisplay = sWatch.elapsed.inMinutes.toString().padLeft(2, "0") + ":"
        + (sWatch.elapsed.inSeconds%60).toString().padLeft(2,"0") + ":"
        + (sWatch.elapsed.inMilliseconds%1000).toString().padLeft(3,"0");
    });
  }

  void startStopwatch(){
    setState(() {
      // this enables start and stop buttons
      stopIsPressed = false;
      startIsPressed = false;
    });
    sWatch.start();
    startTimer();
  }

  void stopStopwatch(){
    setState(() {
      // this disables stop and enables reset
      stopIsPressed = true;
      resetIsPressed = false;
    });
    sWatch.stop();
  }

  void resetStopwatch(){
    setState(() {
      // this disables start and reset
      startIsPressed = true;
      resetIsPressed = true;
    });
    sWatch.reset();
    stopTimeToDtisplay = "00:00:00";
  }

  Widget stopwatch(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stopTimeToDtisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: startIsPressed ? startStopwatch : null,
                        child: Text(
                          'Start',
                        ),
                      ),
                      RaisedButton(
                        onPressed: stopIsPressed ? null : stopStopwatch ,
                        child: Text(
                          'Stop',
                        ),
                      ),
                      RaisedButton(
                        onPressed: resetIsPressed ? null : resetStopwatch,
                        child: Text(
                          'Reset',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: <Widget>[
            Text('Stopwatch'),
            Text('Times')
          ],
          labelPadding: EdgeInsets.only( bottom: 10),
          labelStyle: TextStyle( fontSize: 18),
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          stopwatch(),
          Text('Times'),
        ],
        controller: tb,
      ),
    );
  }
}
