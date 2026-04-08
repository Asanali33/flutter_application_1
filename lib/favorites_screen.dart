import 'package:flutter/material.dart';
import 'data.dart';
<<<<<<< HEAD
import 'product_detail_screen.dart'; // ИМПОРТ ҚОСЫЛДЫ
=======
>>>>>>> af1748983e5895345d40250ce6d2e45b58aabcd1

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Таңдаулылар', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Таңдаулылар тізімі бос', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];

<<<<<<< HEAD
=======
                // Варианттар мен бағаны қауіпсіз алу
>>>>>>> af1748983e5895345d40250ce6d2e45b58aabcd1
                final variants = item['variants'] as List?;
                final String startingPrice = (variants != null && variants.isNotEmpty) 
                    ? variants[0]['price'].toString() 
                    : "0";

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
<<<<<<< HEAD
                    // ОНТАП ҚОСЫЛДЫ: Тауарды басқанда өту
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: item),
                        ),
                      );
                    },
=======
>>>>>>> af1748983e5895345d40250ce6d2e45b58aabcd1
                    contentPadding: const EdgeInsets.all(10),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Hero(
                        tag: item['name'],
                        child: Image.network(
<<<<<<< HEAD
=======
                          // ТҮЗЕТІЛДІ: item['image'] орнына images тізімінің бірінші элементі
>>>>>>> af1748983e5895345d40250ce6d2e45b58aabcd1
                          (item['images'] != null && (item['images'] as List).isNotEmpty)
                              ? item['images'][0]
                              : "", 
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.smartphone),
                        ),
                      ),
                    ),
                    title: Text(
                      item['name'] ?? "Атауы жоқ", 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                    ),
                    subtitle: Text(
                      '$startingPrice ₸', 
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15)
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          favoriteItems.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Таңдаулылардан өшірілді'), duration: Duration(seconds: 1)),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}