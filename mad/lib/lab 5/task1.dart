import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _Task();
}

class _Task extends State<Task> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Task 1"))),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: AnimatedOpacity(
                opacity: selected ? 0.2 : 1,
                duration: Duration(seconds: 1),
                child: Text("On this text Animated Opcaity is applied",style: TextStyle(color: Colors.amber),),
              ),
            ),
          ),
          AnimatedContainer(
            width: selected ? 200 : 100,
            height: selected ? 200 : 100,
            color: selected ? Colors.red : Colors.blue,
            alignment:
                selected ? Alignment.center : AlignmentDirectional.topCenter,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: const FlutterLogo(size: 75),
          ),
          ElevatedButton(
            onPressed:
                () => setState(() {
                  selected = !selected;
                }),
            child: Text("Animate"),
          ),
        ],
      ),
    );
  }
}
