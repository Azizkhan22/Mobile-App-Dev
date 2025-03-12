import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/box-8.jpg', // Image from assets
              width: 400,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.home, size: 35, color: Colors.blue,),
              SizedBox(width: 20),
              Icon(Icons.search, size: 35, color: Colors.blue,),
              SizedBox(width: 20),
              Icon(Icons.favorite, size: 35, color: Colors.blue,),
              SizedBox(width: 20),
              Icon(Icons.shopping_bag, size: 35, color: Colors.blue,),
            ],),
            SizedBox(height: 20),
            Center(child: Text("Very interesting framework, I hope sir we enjoy every lab of this Course") ,),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Button Pressed!");
              },
              child: Text("Click Me"),
            )
            
          ]
        )
      ),
    );    
  }

}
