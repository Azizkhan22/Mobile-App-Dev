import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/profile/screens/profile_screen.dart';

class AppRoutes {
  // Route names
  static const String login = '/';
  static const String home = '/home';
  static const String profile = '/profile';

  // Route mapping
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
