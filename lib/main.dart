import 'package:flutter/material.dart';
import 'package:receipe_app/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 35, 42, 59)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
