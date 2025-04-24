import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Future<Map<String, dynamic>>? _postFuture;
  Future<Map<String, dynamic>> fetchRandomPost() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  void _loadPost() {
    setState(() {
      _postFuture = fetchRandomPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Random Post"))),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _loadPost, child: Text("See Post")),
            FutureBuilder<Map<String, dynamic>>(
              future: _postFuture,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                else if (snapshot.hasError) {
                  return Text("error : ${snapshot.error}");
                }
                else if (snapshot.hasData) {
                  final post = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('${post['title']}\n\n${post['body']}'),
                  );
                } else {
                  return Center(child: Text('Press the button to load post'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
