import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,
      
      // Set application title
      title: 'Flutter Navigation App',
      
      // Define theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      
      // Define initial route
      initialRoute: AppRoutes.login,
      
      // Register named routes
      routes: AppRoutes.routes,
    );
  }
}
