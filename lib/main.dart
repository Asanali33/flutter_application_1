import 'package:flutter/material.dart';

void main() {
  runApp(const MyTeamApp());
}

// Себетке алдын ала қосылған тауарлар
List<Map<String, dynamic>> cartItems = [
  {
    'name': 'iPhone 15 Pro',
    'price': 649990,
    'image': 'https://ir.ozone.ru/s3/multimedia-1-o/7129349196.jpg',
    'isSelected': true,
    'quantity': 1,
  },
  {
    'name': 'Samsung Galaxy S24 Ultra',
    'price': 599990,
    'image': 'https://ir.ozone.ru/s3/multimedia-f/w1200/6896605947.jpg',
    'isSelected': true,
    'quantity': 1,
  },
];

// Таңдаулылар тізімі
List<Map<String, dynamic>> favoriteItems = [];

class MyTeamApp extends StatelessWidget {
  const MyTeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sellpak Store',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainNavigation(),
    );
  }
}

// --- 1. НАВИГАЦИЯ ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Басты'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Таңдаулы'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Себет'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

// --- 2. БАСТЫ ЭКРАН (Жүрекше логикасымен жаңартылды) ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SellPak - Смартфондар'), centerTitle: true),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: phoneProducts.length,
            itemBuilder: (context, index) {
              final phone = phoneProducts[index];
              // Тауар таңдаулылар тізімінде бар ма екенін тексеру
              bool isFavorite = favoriteItems.any((item) => item['name'] == phone['name']);

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Expanded(child: Image.network(phone['image'], fit: BoxFit.contain)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(phone['name'], style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${phone['price']} ₸', style: const TextStyle(color: Colors.red, fontSize: 16)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartItems.add({...phone, 'isSelected': true, 'quantity': 1});
                                  },
                                  child: const Text('Сатып алу'),
                                ),
                              ),
                              IconButton(
                                // Егер таңдалған болса - толы қызыл жүрекше, болмаса - бос жүрекше
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// --- 3. ТАҢДАУЛЫЛАР БЕТІ ---
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Таңдаулылар'), centerTitle: true),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('Таңдаулылар тізімі бос'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(item['image'], width: 50),
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item['price']} ₸', style: const TextStyle(color: Colors.red)),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          favoriteItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// --- 4. СЕБЕТ БЕТІ ---
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get totalAmount {
    int sum = 0;
    for (var item in cartItems) {
      if (item['isSelected'] == true) {
        sum += (item['price'] as int) * (item['quantity'] as int);
      }
    }
    return sum;
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Өшіруді растау'),
        content: const Text('Тауарды өшіресіз бе әлде таңдаулыларға сақтайсыз ба?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Болдырмау', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              favoriteItems.add(cartItems[index]);
              setState(() => cartItems.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Таңдаулылар'),
          ),
          TextButton(
            onPressed: () {
              setState(() => cartItems.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Өшіру', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Себет'), centerTitle: true),
      body: cartItems.isEmpty
          ? const Center(child: Text('Себет әзірге бос', style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        child: Column(
                          children: [
                            CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: item['isSelected'],
                              onChanged: (bool? value) {
                                setState(() {
                                  item['isSelected'] = value;
                                });
                              },
                              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${item['price']} ₸', style: const TextStyle(color: Colors.red)),
                              secondary: Image.network(item['image'], width: 50, fit: BoxFit.contain),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                    onPressed: () {
                                      if (item['quantity'] > 1) {
                                        setState(() => item['quantity']--);
                                      } else {
                                        _showDeleteDialog(index);
                                      }
                                    },
                                  ),
                                  Text('${item['quantity']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: Colors.orange),
                                    onPressed: () {
                                      setState(() => item['quantity']++);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Жалпы сумма:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('$totalAmount ₸', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          onPressed: () {},
                          child: const Text('Жалғастыру', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// --- 5. ПРОФИЛЬ ЭКРАНЫ ---
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
            const Text('Сүндет Назар', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('sundet.nazar@email.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.orange),
                    title: const Text('Тапсырыстар тарихы'),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.favorite_border, color: Colors.orange),
                    title: const Text('Таңдаулылар'),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.orange),
                    title: const Text('Баптаулар'),
                    onTap: () {},
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
                onPressed: () {},
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

final List<Map<String, dynamic>> phoneProducts = [
  {'name': 'iPhone 15 Pro', 'price': 649990, 'image': 'https://ir.ozone.ru/s3/multimedia-1-o/7129349196.jpg'},
  {'name': 'Samsung Galaxy S24 Ultra', 'price': 599990, 'image': 'https://ir.ozone.ru/s3/multimedia-f/w1200/6896605947.jpg'},
  {'name': 'Xiaomi 14 Ultra', 'price': 499990, 'image': 'https://avatars.mds.yandex.net/get-mpic/15106342/2a00000196b4e64d596c1649841cc2ccd54b/orig'},
  {'name': 'HUAWEI Pura 70 Ultra', 'price': 549990, 'image': 'https://i.ebayimg.com/images/g/3T0AAOSw3otoS-O9/s-l500.jpg'},
  {'name': 'Nothing Phone (2)', 'price': 320000, 'image': 'https://avatars.mds.yandex.net/get-mpic/1526692/2a0000018e743c24e02eaeff0eaff8ef9cf1/orig'},
  {'name': 'Google Pixel 8 Pro', 'price': 420000, 'image': 'https://avatars.mds.yandex.net/get-mpic/8382397/2a0000019059a4c75a09fa81eb207bb1a146/orig'},
];