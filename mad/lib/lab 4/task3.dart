import 'package:flutter/material.dart';

class ScrollableListView extends StatelessWidget {
  final List<String> items; // List of items

  ScrollableListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scrollable List")),
      body: ListView.builder(
        itemCount: items.length, // Total items in list
        itemBuilder: (context, index) {
          return Card(
            elevation: 4, // Adds shadow effect
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(Icons.list, color: Colors.blue), // Icon on the left
              title: Text(
                items[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Subtitle for ${items[index]}"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), // Arrow icon
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Tapped on ${items[index]}")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
