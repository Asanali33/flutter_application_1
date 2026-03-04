import 'package:flutter/material.dart';

void main() {
  runApp(const MyTeamApp());
}

class MyTeamApp extends StatelessWidget {
  const MyTeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Оң жақтағы "Debug" жазуын алып тастайды
      title: 'Sellpak Store', // Тек бір ғана title қалдырдық
      theme: ThemeData(primarySwatch: Colors.orange), 
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SellPak - Смартфондар'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Бүгін жоба басталды!\nЖақында бұл жерде телефондар болады.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}