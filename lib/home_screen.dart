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
  String selectedBrand = "Барлығы";
  String selectedRam = "Барлығы"; // RAM үшін айнымалы
  String sortBy = "Әдепкі";

  @override
  Widget build(BuildContext context) {
    // 1. Фильтрлеу логикасы (RAM тексеруі қосылды)
    List<Map<String, dynamic>> filteredProducts = phoneProducts.where((product) {
      final matchesSearch = product['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesBrand = selectedBrand == "Барлығы" || product['brand'] == selectedBrand;
      
      // RAM-ды variants ішінен іздеу
      final matchesRam = selectedRam == "Барлығы" || 
          (product['variants'] as List).any((v) => v['ram'] == selectedRam);

      return matchesSearch && matchesBrand && matchesRam;
    }).toList();

    // 2. Сұрыптау логикасы
    if (sortBy == "Арзан") {
      filteredProducts.sort((a, b) {
        final priceA = (a['variants'] as List)[0]['price'] ?? 0;
        final priceB = (b['variants'] as List)[0]['price'] ?? 0;
        return priceA.compareTo(priceB);
      });
    } else if (sortBy == "Қымбат") {
      filteredProducts.sort((a, b) {
        final priceA = (a['variants'] as List)[0]['price'] ?? 0;
        final priceB = (b['variants'] as List)[0]['price'] ?? 0;
        return priceB.compareTo(priceA);
      });
    } else if (sortBy == "Рейтинг") {
      filteredProducts.sort((a, b) => (b['rating'] ?? 0.0).compareTo(a['rating'] ?? 0.0));
    }

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
          // Іздеу жолағы
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: const InputDecoration(
                  hintText: "Смартфон іздеу...",
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // Бренд фильтрі
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: ["Барлығы", "Apple", "Samsung", "Xiaomi", "OPPO"].map((brand) {
                final isSelected = selectedBrand == brand;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(brand),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => selectedBrand = brand),
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }).toList(),
            ),
          ),

          // --- ЖАҢА: RAM ФИЛЬТРІ ---
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: ["Барлығы (RAM)", "4 GB", "6 GB", "8 GB", "12 GB"].map((ram) {
                final isSelected = selectedRam == ram;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(ram),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => selectedRam = ram),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }).toList(),
            ),
          ),
          // ------------------------

          // Сұрыптау
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.sort, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: sortBy,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) => setState(() => sortBy = newValue!),
                  items: <String>['Әдепкі', 'Арзан', 'Қымбат', 'Рейтинг']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              ],
            ),
          ),

          // Тауарлар торы
          Expanded(
            child: filteredProducts.isEmpty 
              ? const Center(child: Text("Ештеңе табылмады 😕"))
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
                    final variants = phone['variants'] as List;
                    final int startingPrice = variants.isNotEmpty ? (variants[0]['price'] ?? 0) : 0;
                    
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Image.network(
                                        phone['image'], 
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.smartphone, size: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(phone['name'], 
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 4),
                                      Text('$startingPrice ₸', 
                                        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber, size: 14),
                                          Text(" ${phone['rating'] ?? 0.0}", style: const TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 5, top: 5,
                              child: IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border, 
                                  color: Colors.red
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite) {
                                      favoriteItems.removeWhere((i) => i['name'] == phone['name']);
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