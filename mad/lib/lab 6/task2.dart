import 'package:flutter/material.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'images/profilepic.jpg', // Ensure this path is correct and added to pubspec.yaml
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aziz Ullah',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mobile App Developer | Flutter Enthusiast',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Follow button action
                      },
                      child: const Text('Follow'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Message button action
                      },
                      child: const Text('Message'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}