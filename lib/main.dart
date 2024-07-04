import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(FootballGameApp());
  
}

class FootballGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Football Game',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightGreenAccent, // Set the background color
      ),
      home: FootballGameScreen(),
      
    );
  }
}

class FootballGameScreen extends StatefulWidget {
  @override
  _FootballGameScreenState createState() => _FootballGameScreenState();
}

class _FootballGameScreenState extends State<FootballGameScreen> {
  int teamAScore = 0;
  int teamBScore = 0;
  bool isTimerRunning = false;
  int countdownTime = 60; // 1 minutes
  Timer? timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownTime < 1) {
          timer.cancel();
          isTimerRunning = false;
        } else {
          countdownTime--;
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      isTimerRunning = false;
    });
    timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      countdownTime = 60;
      isTimerRunning = false;
    });
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Match Countdown',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              '${(countdownTime ~/ 60).toString().padLeft(2, '0')}:${(countdownTime % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Team A',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$teamAScore',
                      style: TextStyle(fontSize: 36.0),
                    ),
                    ElevatedButton(
                      onPressed: isTimerRunning ? null : () => setState(() => teamAScore++),
                      child: Text('Goal'),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Team B',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$teamBScore',
                      style: TextStyle(fontSize: 36.0),
                    ),
                    ElevatedButton(
                      onPressed: isTimerRunning ? null : () => setState(() => teamBScore++),
                      child: Text('Goal'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: isTimerRunning ? null : startTimer,
                  child: Text('Start Timer'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text('Stop Timer'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset Timer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
