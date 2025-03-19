import 'package:flutter/material.dart';

class Tree extends StatelessWidget {
  const Tree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Lab 4"))),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Center(child: Text("Believe you can and you are halfway there")),
          SizedBox(height: 50,),
          BackButton(color: Colors.amber),
          SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.red),
              Icon(Icons.audiotrack, color: Colors.red),
              Icon(Icons.beach_access, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
