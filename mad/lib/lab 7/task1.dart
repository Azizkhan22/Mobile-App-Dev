import 'package:flutter/material.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerApp();
}

class _TimerApp extends State<TimerApp> {
  int _timer = 30;
  bool _isRunning = false;
  void startTimer() async {
    if (!_isRunning){
      _isRunning = true;
      while (_isRunning && _timer > 0){
        await Future.delayed(Duration(seconds:1));
        setState(() { _timer-- ;});
      }      
    }
  }

  void resetTimer() {

      _isRunning = false;
      setState(() {
        _timer = 30;
      });    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Timer App"),)        
      ),
      body: Center(
        child: Column(
        children: [
          Text('$_timer'),
          ElevatedButton(onPressed: startTimer, child: Text(_isRunning ? "Running..." : "Start")),
          ElevatedButton(onPressed: resetTimer, child: Text("Reset"))
        ],
      ),
      ) 
    );
  }
}