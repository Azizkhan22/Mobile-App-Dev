import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  const Design({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LAB # 3"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, // Makes text bold
          fontSize: 20, // Adjust size if needed
          color: Colors.black
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(              
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(30),              
              decoration: BoxDecoration(  
                color: Colors.red,              
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child : Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                height: double.infinity,                
                decoration: BoxDecoration(
                  color: Colors.blue,                  
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child : Image.asset(
              'images/box-8.jpg', // Image from assets              
              fit: BoxFit.cover,
            ),
              )
            )
          ],
        ),
      ),
    );
  }
}