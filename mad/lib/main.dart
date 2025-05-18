import 'package:flutter/material.dart';
import './lab 10/app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // Import the generated file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform, // picks the right config for web, android, ios
  );

  runApp(MyApp());
}
