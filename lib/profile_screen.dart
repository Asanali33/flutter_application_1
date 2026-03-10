import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Жеке кабинет'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange,
                child: Text('СН', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Сүндетбек Назар', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('sundetbek.nazar@email.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.orange),
                    title: const Text('Тапсырыстар тарихы'),
                    onTap: () {
                      // Тарих батырмасы істейді
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Тарих бос')));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.favorite_border, color: Colors.orange),
                    title: const Text('Таңдаулылар'),
                    onTap: () {
                      // Таңдаулыларға өту
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Таңдаулылар бөліміне өту')));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.orange),
                    title: const Text('Баптаулар'),
                    onTap: () {
                      // Баптаулар істейді
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Баптаулар ашылды')));
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                onPressed: () {
                  // Шығу батырмасы істейді
                  Navigator.pop(context);
                },
                child: const Text('Шығу', style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}