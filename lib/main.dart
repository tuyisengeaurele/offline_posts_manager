import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const OfflinePostsManagerApp());
}

class OfflinePostsManagerApp extends StatelessWidget {
  const OfflinePostsManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Posts Manager',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF14B8A6),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}
