import 'package:flutter/material.dart';

void main() {
  runApp(const MyTeamApp());
}

class MyTeamApp extends StatelessWidget {
  const MyTeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Біздің Ортақ Жоба',
=======
      title: 'Ортақ Жоба',
>>>>>>> 5aa00f9407097c31a6e79abb6d62a6a794d04fa9
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