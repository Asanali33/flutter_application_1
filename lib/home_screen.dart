import 'package:flutter/material.dart';
import 'data.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  
  @override
  Widget build(BuildContext context) {
    final filteredProducts = phoneProducts.where((product) {
      return product['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('SellPak Store', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Смартфон іздеу...",
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          Expanded(
            child: filteredProducts.isEmpty 
              ? const Center(child: Text("Өкінішке орай, ештеңе табылмады 😕"))
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final phone = filteredProducts[index];
                    
                    // ТҮЗЕТІЛДІ: Бағаны variants ішінен алу (null-ды құрту үшін)
                    final variants = phone['variants'] as List?;
                    final int startingPrice = (variants != null && variants.isNotEmpty) 
                        ? (variants[0]['price'] ?? 0) 
                        : 0;

                    bool isFavorite = favoriteItems.any((item) => item['name'] == phone['name']);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetailScreen(product: phone)),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Stack( 
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(phone['image'], fit: BoxFit.contain),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(phone['name'], 
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), 
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 4),
                                      
                                      // ТҮЗЕТІЛДІ: Енді 'null' орнына нақты баға шығады
                                      Text('$startingPrice ₸', 
                                        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                      
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orange,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Себетке қосқанда да бірінші нұсқаның бағасын тіркеп жіберемім
                                              cartItems.add({
                                                ...phone, 
                                                'price': startingPrice, 
                                                'isSelected': true, 
                                                'quantity': 1
                                              });
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Себетке қосылды!'), duration: Duration(seconds: 1)),
                                            );
                                          },
                                          child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite) {
                                      favoriteItems.removeWhere((item) => item['name'] == phone['name']);
                                    } else {
                                      favoriteItems.add(phone);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}