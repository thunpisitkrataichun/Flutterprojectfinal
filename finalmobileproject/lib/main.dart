import 'package:flutter/material.dart';
import 'widgets/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Class Schedule App',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
