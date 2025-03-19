import "package:flutter/material.dart";

class ComplexWidget extends StatelessWidget {
  const ComplexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.toc, color: Colors.black26, size: 35),
                onPressed: () {
                  print("Button is pressed");
                },
              ),
            ),
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.perm_identity,
                      color: Colors.black26,
                      size: 30,
                    ),
                    onPressed: () {
                      print("Button is pressed");
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.black26,
                      size: 30,
                    ),
                    onPressed: () {
                      print("Button is pressed");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FOOD DELIVERY",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Order any food that you like, from desi cusines and fast food",
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.add_alarm_outlined),                      
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
