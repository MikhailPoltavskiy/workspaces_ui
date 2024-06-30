import 'package:flutter/material.dart';
import 'package:workspaces_ui/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> listItem = [
      'Savva',
      'Olluco',
      'Loona',
      'Folk',
      'White Rabbit',
      'Sage',
      'Maya',
      'Jun',
      'Onest',
      'Probka на Цветном',
    ];
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: HomeScreen(
          listItem: listItem,
        ),
      ),
    );
  }
}
