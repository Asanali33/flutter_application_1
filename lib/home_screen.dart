import 'package:flutter/material.dart';
import 'data.dart'; // phoneProducts осы жерден алынады
import 'product_detail_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Күй айнымалылары
  String searchQuery = "";
  String selectedBrand = "Барлығы";
  String selectedRam = "Барлығы"; 
  String selectedBattery = "Барлығы";
  String selectedCamera = "Барлығы";
  String sortBy = "Әдепкі";

  List<String> selectedMemories = [];
  List<String> selectedColors = [];
  bool onlyWithDiscount = false;

  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  double minPrice = 0;
  double maxPrice = 2000000; 

  // Мәтіннен санды бөліп алу функциясы (мысалы: "5000 mAh" -> 5000)
  int _parseNumber(String value) {
    return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }

  // Фильтр терезесін шығару (Bottom Sheet)
  void _showFilterBottomSheet() {
    _minPriceController.text = minPrice > 0 ? minPrice.toInt().toString() : '';
    _maxPriceController.text = maxPrice < 2000000 ? maxPrice.toInt().toString() : '';

    double tempMinPrice = minPrice;
    double tempMaxPrice = maxPrice;
    String tempBrand = selectedBrand;
    String tempRam = selectedRam;
    String tempBattery = selectedBattery;
    String tempCamera = selectedCamera;
    List<String> tempMemories = List.from(selectedMemories);
    List<String> tempColors = List.from(selectedColors);
    bool tempDiscount = onlyWithDiscount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder( 
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              tempBrand = "Барлығы";
                              tempRam = "Барлығы";
                              tempBattery = "Барлығы";
                              tempCamera = "Барлығы";
                              tempMemories.clear();
                              tempColors.clear();
                              tempDiscount = false;
                              _minPriceController.clear();
                              _maxPriceController.clear();
                              tempMinPrice = 0;
                              tempMaxPrice = 2000000;
                            });
                          },
                          child: const Text('Тазалау', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                        ),
                        const Text('Фильтрлер', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildSectionTitle('Бағасы (₸)'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildPriceField(_minPriceController, 'от', (val) => tempMinPrice = double.tryParse(val) ?? 0),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('—', style: TextStyle(color: Colors.grey)),
                            ),
                            _buildPriceField(_maxPriceController, 'до', (val) => tempMaxPrice = double.tryParse(val) ?? 2000000),
                          ],
                        ),
                        const SizedBox(height: 25),
                        _buildSectionTitle('Брендтер'),
                        _buildChoiceChips(["Барлығы", "Apple", "Samsung", "Xiaomi", "OPPO"], tempBrand, (val) => setModalState(() => tempBrand = val)),
                        
                        const SizedBox(height: 25),
                        _buildSectionTitle('Батарея сыйымдылығы'),
                        _buildChoiceChips(["Барлығы", "4500 mAh", "5000 mAh", "6000 mAh"], tempBattery, (val) => setModalState(() => tempBattery = val), color: Colors.green),

                        const SizedBox(height: 25),
                        _buildSectionTitle('Камера (MP)'),
                        _buildChoiceChips(["Барлығы", "12 MP", "48 MP", "50 MP", "108 MP"], tempCamera, (val) => setModalState(() => tempCamera = val), color: Colors.blue),

                        const SizedBox(height: 25),
                        _buildSectionTitle('Жедел жад (RAM)'),
                        _buildChoiceChips(["Барлығы", "4 GB", "6 GB", "8 GB", "12 GB"], tempRam, (val) => setModalState(() => tempRam = val), color: Colors.deepPurple),
                        
                        const SizedBox(height: 25),
                        _buildSectionTitle('Память'),
                        _buildMultiChoiceChips(["128 GB", "256 GB", "512 GB"], tempMemories, (val, selected) {
                          setModalState(() => selected ? tempMemories.add(val) : tempMemories.remove(val));
                        }),
                        const SizedBox(height: 25),
                        _buildSectionTitle('Түсі'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 15,
                          children: [
                            _buildColorDot(Colors.black, 'Қара', tempColors, setModalState),
                            _buildColorDot(Colors.white, 'Ақ', tempColors, setModalState),
                            _buildColorDot(Colors.blue, 'Көк', tempColors, setModalState),
                            _buildColorDot(Colors.grey, 'Сұр', tempColors, setModalState),
                          ],
                        ),
                        const SizedBox(height: 25),
                        SwitchListTile(
                          title: const Text('Тек жеңілдігі барлар', style: TextStyle(fontWeight: FontWeight.w600)),
                          value: tempDiscount,
                          activeColor: Colors.orange,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (val) => setModalState(() => tempDiscount = val),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          setState(() {
                            minPrice = tempMinPrice;
                            maxPrice = tempMaxPrice;
                            selectedBrand = tempBrand;
                            selectedRam = tempRam;
                            selectedBattery = tempBattery;
                            selectedCamera = tempCamera;
                            selectedMemories = tempMemories;
                            selectedColors = tempColors;
                            onlyWithDiscount = tempDiscount;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Нәтижені көрсету', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Өнімдерді сүзгілеу логикасы
    List<Map<String, dynamic>> filteredProducts = phoneProducts.where((product) {
      final q = searchQuery.toLowerCase();
      final matchesSearch = product['name'].toString().toLowerCase().contains(q) ||
                            (product['battery'] ?? '').toString().toLowerCase().contains(q) ||
                            (product['camera'] ?? '').toString().toLowerCase().contains(q);
=======
    // 1. Фильтрлеу логикасы (RAM тексеруі түзетілді)
    List<Map<String, dynamic>> filteredProducts = phoneProducts.where((product) {
      final matchesSearch = product['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesBrand = selectedBrand == "Барлығы" || product['brand'] == selectedBrand;
      
      // RAM-ды variants ішінен іздеу (бос орын мәселесі шешілді)
      final matchesRam = selectedRam == "Барлығы" || 
          (product['variants'] as List).any((v) => 
            v['ram'].toString().replaceAll(' ', '') == selectedRam.replaceAll(' ', ''));
>>>>>>> 18531ef9f022f2350cc8c87f2dba6b9720bf76f6

      final matchesBrand = selectedBrand == "Барлығы" || product['brand'] == selectedBrand;

      // Батарея: Таңдалған мәнге ДЕЙІНГІЛЕР (<=)
      bool matchesBattery = true;
      if (selectedBattery != "Барлығы") {
        int productBattery = _parseNumber(product['battery'] ?? '0');
        int limitBattery = _parseNumber(selectedBattery);
        matchesBattery = productBattery <= limitBattery;
      }

      // Камера: Таңдалған мәнге ДЕЙІНГІЛЕР (<=)
      bool matchesCamera = true;
      if (selectedCamera != "Барлығы") {
        int productCamera = _parseNumber(product['camera'] ?? '0');
        int limitCamera = _parseNumber(selectedCamera);
        matchesCamera = productCamera <= limitCamera;
      }
      
      final double productPrice = (product['variants'] as List).isNotEmpty ? (product['variants'][0]['price'] ?? 0).toDouble() : 0.0;
      final matchesPrice = productPrice >= minPrice && productPrice <= maxPrice;
      
      final matchesRam = selectedRam == "Барлығы" || (product['variants'] as List).any((v) => v['ram'] == selectedRam);
      final matchesMemory = selectedMemories.isEmpty || (product['variants'] as List).any((v) => selectedMemories.contains(v['memory']));
      final matchesDiscount = !onlyWithDiscount || product['hasDiscount'] == true;
      
      return matchesSearch && matchesBrand && matchesBattery && matchesCamera && matchesPrice && matchesRam && matchesMemory && matchesDiscount;
    }).toList();

    // Сұрыптау логикасы
    if (sortBy == 'Арзан') {
      filteredProducts.sort((a, b) => a['variants'][0]['price'].compareTo(b['variants'][0]['price']));
    } else if (sortBy == 'Қымбат') {
      filteredProducts.sort((a, b) => b['variants'][0]['price'].compareTo(a['variants'][0]['price']));
    } else if (sortBy == 'Рейтинг') {
      filteredProducts.sort((a, b) => (b['rating'] ?? 0.0).compareTo(a['rating'] ?? 0.0));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('SellPak Store', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
      body: Column(
        children: [
          // Іздеу жолағы
          Padding(
<<<<<<< HEAD
            padding: const EdgeInsets.all(16.0),
=======
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
              children: ["Барлығы", "4 GB", "6 GB", "8 GB", "12 GB"].map((ram) {
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
>>>>>>> 18531ef9f022f2350cc8c87f2dba6b9720bf76f6
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => searchQuery = val),
                      decoration: const InputDecoration(
                        hintText: "Модель, батарея немесе камера...",
                        prefixIcon: Icon(Icons.search, color: Colors.orange),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showFilterBottomSheet,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.tune_rounded, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          // Нәтижелер саны және Сұрыптау
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${filteredProducts.length} тауар табылды", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  value: sortBy,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  onChanged: (val) => setState(() => sortBy = val!),
                  items: ['Әдепкі', 'Арзан', 'Қымбат', 'Рейтинг'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                ),
              ],
            ),
          ),
          // Тауарлар тізімі
          Expanded(
            child: filteredProducts.isEmpty 
              ? const Center(child: Text("Ештеңе табылмады 😕"))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.61, 
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredProducts.length,
<<<<<<< HEAD
                  itemBuilder: (context, index) => _buildProductCard(filteredProducts[index]),
=======
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
                                        (phone['images'] as List)[0], // images тізімінен бірінші суретті алу
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
>>>>>>> 18531ef9f022f2350cc8c87f2dba6b9720bf76f6
                ),
          ),
        ],
      ),
    );
  }

  // Көмекші виджеттер
  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  Widget _buildPriceField(TextEditingController controller, String prefix, Function(String) onChange) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixText: '$prefix ',
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildChoiceChips(List<String> items, String selected, Function(String) onSelect, {Color color = Colors.orange}) {
    return Wrap(
      spacing: 8,
      children: items.map((item) => ChoiceChip(
        label: Text(item),
        selected: selected == item,
        onSelected: (s) => onSelect(item),
        selectedColor: color,
        labelStyle: TextStyle(color: selected == item ? Colors.white : Colors.black),
      )).toList(),
    );
  }

  Widget _buildMultiChoiceChips(List<String> items, List<String> selectedList, Function(String, bool) onSelect) {
    return Wrap(
      spacing: 8,
      children: items.map((item) => FilterChip(
        label: Text(item),
        selected: selectedList.contains(item),
        onSelected: (s) => onSelect(item, s),
        selectedColor: Colors.orange,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(color: selectedList.contains(item) ? Colors.white : Colors.black),
      )).toList(),
    );
  }

  Widget _buildColorDot(Color color, String name, List<String> selectedColors, StateSetter setModalState) {
    bool isSelected = selectedColors.contains(name);
    return GestureDetector(
      onTap: () => setModalState(() => isSelected ? selectedColors.remove(name) : selectedColors.add(name)),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSelected ? Colors.orange : Colors.transparent, width: 2)),
        child: CircleAvatar(
          radius: 12, 
          backgroundColor: color, 
          child: isSelected ? Icon(Icons.check, size: 14, color: color == Colors.white ? Colors.black : Colors.white) : null,
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> phone) {
    final int price = (phone['variants'] as List).isNotEmpty ? phone['variants'][0]['price'] : 0;
    
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: phone))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Hero(
                      tag: phone['name'],
                      child: Image.network(phone['image'], fit: BoxFit.contain),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phone['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.battery_std, size: 12, color: Colors.green),
                          const SizedBox(width: 4),
                          Text("${phone['battery'] ?? '5000 mAh'}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.camera_alt_outlined, size: 12, color: Colors.blue),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text("${phone['camera'] ?? '48 MP'}", 
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('$price ₸', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                          Text(" ${phone['rating'] ?? 0.0}", style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5, right: 5,
              child: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red, size: 22),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}