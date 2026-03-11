import 'package:flutter/material.dart';
import 'data.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Әдемі жоғарғы бөлім (Суретпен)
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Hero(
                  tag: product['name'], // Анимация үшін
                  child: Image.network(product['image'], fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          
          // Ақпараттық бөлім
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(product['name'], 
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                        ),
                        const Icon(Icons.share_outlined, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${product['price']} ₸', 
                      style: const TextStyle(fontSize: 24, color: Colors.orange, fontWeight: FontWeight.w800)),
                    
                    const SizedBox(height: 25),
                    const Text('Сипаттамасы', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 12),
                    Text(product['description'] ?? "Сипаттамасы жақында қосылады...",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5)),
                    
                    const SizedBox(height: 30),
                    // Қосымша стикерлер
                    Row(
                      children: [
                        _buildFeatureIcon(Icons.local_shipping_outlined, "Тегін жеткізу"),
                        const SizedBox(width: 15),
                        _buildFeatureIcon(Icons.verified_user_outlined, "1 жыл кепілдік"),
                      ],
                    ),
                    const SizedBox(height: 100), // Батырма үшін орын
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Себетке қосу батырмасы (Төменде қатып тұрады)
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
          ),
          onPressed: () {
            cartItems.add({...product, 'isSelected': true, 'quantity': 1});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product['name']} себетке қосылды!'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.orange,
              ),
            );
          },
          child: const Text('Себетке қосу', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.orange),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange)),
        ],
      ),
    );
  }
}