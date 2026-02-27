import 'package:flutter/material.dart';

void main() {
  runApp(const MyTeamApp());
}

class MyTeamApp extends StatelessWidget {
  const MyTeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Біздің Ортақ Жоба',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Командалық Жобамыз')),
      body: const Center(
        child: Text('Бүгін жоба басталды! '),
      ),
    );
  }
}