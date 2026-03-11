  import 'package:flutter/material.dart';

  // 1. Тауарлар тізімі (Жад нұсқалары мен реалистік бағалар қосылды)
  final List<Map<String, dynamic>> phoneProducts = [
    {
      'name': 'iPhone 15 Pro', 
      'image': 'https://ir.ozone.ru/s3/multimedia-1-o/7129349196.jpg',
      'description': 'Титан корпусы, A17 Pro чипі және кәсіби деңгейдегі 48 Мп камера жүйесі.',
      'variants': [
        {'ram': '128GB', 'price': 580000},
        {'ram': '256GB', 'price': 650000},
        {'ram': '512GB', 'price': 780000},
      ],
    },
    {
      'name': 'Samsung Galaxy S24 Ultra', 
      'image': 'https://ir.ozone.ru/s3/multimedia-f/w1200/6896605947.jpg',
      'description': 'Galaxy AI мүмкіндіктері, 200 Мп негізгі камера және кірістірілген S Pen.',
      'variants': [
        {'ram': '64GB', 'price': 420000},
        {'ram': '128GB', 'price': 480000},
        {'ram': '256GB', 'price': 540000},
      ],
    },
    {
      'name': 'Xiaomi 14 Ultra', 
      'image': 'https://avatars.mds.yandex.net/get-mpic/15106342/2a00000196b4e64d596c1649841cc2ccd54b/orig',
      'description': 'Leica оптикасымен жабдықталған кәсіби фото-флагман. 1-дюймдік сенсор.',
      'variants': [
        {'ram': '64GB', 'price': 380000},
        {'ram': '128GB', 'price': 430000},
        {'ram': '256GB', 'price': 499990},
      ],
    },
    {
      'name': 'HUAWEI Pura 70 Ultra', 
      'image': 'https://i.ebayimg.com/images/g/3T0AAOSw3otoS-O9/s-l500.jpg',
      'description': 'XMAGE камера жүйесі және жылжымалы объектив. Өнер мен технология үйлесімі.',
      'variants': [
        {'ram': '64GB', 'price': 390000},
        {'ram': '128GB', 'price': 450000},
        {'ram': '256GB', 'price': 549990},
      ],
    },
    {
      'name': 'Nothing Phone (2)', 
      'image': 'https://avatars.mds.yandex.net/get-mpic/1526692/2a0000018e743c24e02eaeff0eaff8ef9cf1/orig',
      'description': 'Ерекше Glyph интерфейсі, мөлдір корпус және таза Nothing OS.',
      'variants': [
        {'ram': '64GB', 'price': 220000},
        {'ram': '128GB', 'price': 270000},
        {'ram': '256GB', 'price': 320000},
      ],
    },
    {
      'name': 'Google Pixel 8 Pro', 
      'image': 'https://avatars.mds.yandex.net/get-mpic/8382397/2a0000019059a4c75a09fa81eb207bb1a146/orig',
      'description': 'Google-дің ең ақылды смартфоны. Жасанды интеллект көмегімен суреттерді өңдеу.',
      'variants': [
        {'ram': '64GB', 'price': 290000},
        {'ram': '128GB', 'price': 350000},
        {'ram': '256GB', 'price': 420000},
      ],
    },
  ];

  // 2. Бұл айнымалыларды өзгертпедім
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> favoriteItems = [];