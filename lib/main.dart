import 'package:flutter/material.dart';

void main() {
  runApp(const MyTeamApp());
}

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
      home: const MainNavigation(), // Басты навигацияға сілтеме
    );
  }
}

// --- 1. НАВИГАЦИЯ (Экрандарды ауыстырып тұратын құрылым) ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Экрандар тізімі
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Себет әзірге бос', style: TextStyle(fontSize: 20))), // Cart Screen (уақытша)
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Басты'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Себет'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

// --- 2. БАСТЫ ЭКРАН (Home) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SellPak - Смартфондар'), centerTitle: true),
      body: GridView.builder(
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
          return GestureDetector(
            // Тауарды басқанда Detail бетіне өту
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetailScreen(product: phone)),
            ),
            child: Card(
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
                        Text(phone['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(phone['price'], style: const TextStyle(color: Colors.red, fontSize: 16)),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Сатып алу'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- 3. ТАУАРДЫҢ ТОЛЫҚ БЕТІ (Product Detail) ---
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.network(product['image'], height: 300),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(product['price'], style: const TextStyle(fontSize: 22, color: Colors.red, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Text('Сипаттамасы:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(product['desc'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Себетке қосылды!')),
                        );
                      },
                      child: const Text('Себетке қосу', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 4. ПРОФИЛЬ ЭКРАНЫ ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Жеке кабинет'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Қонақ аватары
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person_outline, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Қош келдіңіз!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Тапсырыс беру үшін жүйеге кіріңіз',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // КІРУ БАТЫРМАСЫ
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Болашақта логин бетіне өту үшін
                },
                child: const Text('Кіру', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 15),

            // ТІРКЕЛУ БАТЫРМАСЫ
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Болашақта тіркелу бетіне өту үшін
                },
                child: const Text('Тіркелу', style: TextStyle(color: Colors.orange, fontSize: 18)),
              ),
            ),
            
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Көмек орталығы'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Қосымша туралы'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Тауарлар тізімі (өзгеріссіз)
final List<Map<String, dynamic>> phoneProducts = [
  {
    'name': 'iPhone 15 Pro',
    'price': '649 990 ₸',
    'image': 'https://ir.ozone.ru/s3/multimedia-1-o/7129349196.jpg',
    'desc': 'Titanium. So strong. So light. So Pro. Жаңа A17 Pro чипі және керемет камера.',
  },
  {
    'name': 'Samsung Galaxy S24 Ultra',
    'price': '599 990 ₸',
    'image': 'https://ir.ozone.ru/s3/multimedia-f/w1200/6896605947.jpg',
    'desc': 'Galaxy AI is here. Жасанды интеллект көмегімен суреттерді өңдеңіз және аударма жасаңыз.',
  },
  {
    'name': 'Xiaomi 14 Ultra',
    'price': '499 990 ₸',
    'image': 'https://avatars.mds.yandex.net/get-mpic/15106342/2a00000196b4e64d596c1649841cc2ccd54b/orig',
    'desc': 'Leica камерасымен жабдықталған фотофлагман. Кәсіби деңгейдегі суреттер.',
  },
  {
    'name': 'HUAWEI Pura 70 Ultra',
    'price': '549 990 ₸',
    'image': 'https://i.ebayimg.com/images/g/3T0AAOSw3otoS-O9/s-l500.jpg',
    'desc': 'Ultra Speed Snapshot. Вдвижной объектив камерасы бар ең мықты смартфон.',
  },
  {
    'name': 'Nothing Phone (2)',
    'price': '320 000 ₸',
    'image': 'https://avatars.mds.yandex.net/get-mpic/1526692/2a0000018e743c24e02eaeff0eaff8ef9cf1/orig',
    'desc': 'Unique Glyph Interface. Артындағы жарық диодтары арқылы хабарламаларды бақылаңыз.',
  },
  {
    'name': 'Google Pixel 8 Pro',
    'price': '420 000 ₸',
    'image': 'https://avatars.mds.yandex.net/get-mpic/8382397/2a0000019059a4c75a09fa81eb207bb1a146/orig',
    'desc': 'Таза Android жүйесі және Google AI-дың ең үздік пост-өңдеу мүмкіндіктері.',
  },
];