import 'package:flutter/material.dart';
import 'package:mad/lab%207/task2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7',
      theme: ThemeData(      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: PostView()
    );
  }
}
