import 'package:flutter/material.dart';
import 'data.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // ТҮЗЕТІЛГЕН ЖЕРІ: Таңдалған жад нұсқасын сақтайтын айнымалы
  late Map<String, dynamic> selectedVariant;

  @override
  void initState() {
    super.initState();
    // Бастапқыда бірінші нұсқаны таңдаймыз
    selectedVariant = widget.product['variants'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Hero(
                  tag: widget.product['name'],
                  child: Image.network(widget.product['image'], fit: BoxFit.contain),
                ),
              ),
            ),
          ),
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
                          child: Text(widget.product['name'], 
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                        ),
                        const Icon(Icons.share_outlined, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    // ТҮЗЕТІЛГЕН ЖЕРІ: Баға таңдалған жадқа байланысты өзгереді
                    Text('${selectedVariant['price']} ₸', 
                      style: const TextStyle(fontSize: 24, color: Colors.orange, fontWeight: FontWeight.w800)),
                    
                    const SizedBox(height: 25),

                    // ЖАҢАДАН ҚОСЫЛҒАН: Жад таңдау бөлімі
                    const Text('Жад көлемін таңдаңыз:', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 12),
                    Row(
                      children: (widget.product['variants'] as List).map((variant) {
                        bool isSelected = selectedVariant['ram'] == variant['ram'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(variant['ram']),
                            selected: isSelected,
                            selectedColor: Colors.orange,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedVariant = variant;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 25),
                    const Text('Сипаттамасы', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 12),
                    Text(widget.product['description'] ?? "Сипаттамасы жақында қосылады...",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5)),
                    
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        _buildFeatureIcon(Icons.local_shipping_outlined, "Тегін жеткізу"),
                        const SizedBox(width: 15),
                        _buildFeatureIcon(Icons.verified_user_outlined, "1 жыл кепілдік"),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
            // ТҮЗЕТІЛГЕН ЖЕРІ: Себетке таңдалған баға мен жадты қосу
            cartItems.add({
              ...widget.product, 
              'name': '${widget.product['name']} (${selectedVariant['ram']})',
              'price': selectedVariant['price'],
              'isSelected': true, 
              'quantity': 1
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.product['name']} (${selectedVariant['ram']}) себетке қосылды!'),
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