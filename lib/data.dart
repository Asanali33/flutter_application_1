import 'package:flutter/material.dart';

// 1. Тауарлар тізімі
final List<Map<String, dynamic>> phoneProducts = [
  {
    'name': 'iPhone 15 Pro', 
    'price': 649990, 
    'image': 'https://ir.ozone.ru/s3/multimedia-1-o/7129349196.jpg',
    'description': 'Титан корпусы, A17 Pro чипі және кәсіби деңгейдегі 48 Мп камера жүйесі. Жеңіл әрі өте төзімді.'
  },
  {
    'name': 'Samsung Galaxy S24 Ultra', 
    'price': 599990, 
    'image': 'https://ir.ozone.ru/s3/multimedia-f/w1200/6896605947.jpg',
    'description': 'Galaxy AI мүмкіндіктері, 200 Мп негізгі камера және кірістірілген S Pen. Смартфондар әлеміндегі жаңа стандарт.'
  },
  {
    'name': 'Xiaomi 14 Ultra', 
    'price': 499990, 
    'image': 'https://avatars.mds.yandex.net/get-mpic/15106342/2a00000196b4e64d596c1649841cc2ccd54b/orig',
    'description': 'Leica оптикасымен жабдықталған кәсіби фото-флагман. 1-дюймдік сенсор және Snapdragon 8 Gen 3 процессоры.'
  },
  {
    'name': 'HUAWEI Pura 70 Ultra', 
    'price': 549990, 
    'image': 'https://i.ebayimg.com/images/g/3T0AAOSw3otoS-O9/s-l500.jpg',
    'description': 'XMAGE камера жүйесі және жылжымалы объектив. Өнер мен технологияның керемет үйлесімі.'
  },
  {
    'name': 'Nothing Phone (2)', 
    'price': 320000, 
    'image': 'https://avatars.mds.yandex.net/get-mpic/1526692/2a0000018e743c24e02eaeff0eaff8ef9cf1/orig',
    'description': 'Ерекше Glyph интерфейсі, мөлдір корпус және таза Nothing OS. Стиль мен минимализмді сүйетіндерге арналған.'
  },
  {
    'name': 'Google Pixel 8 Pro', 
    'price': 420000, 
    'image': 'https://avatars.mds.yandex.net/get-mpic/8382397/2a0000019059a4c75a09fa81eb207bb1a146/orig',
    'description': 'Google-дің ең ақылды смартфоны. Жасанды интеллект көмегімен суреттерді өңдеу және ең таза Android тәжірибесі.'
  },
];

// 2. Қателерді жою үшін мына айнымалыларды міндетті түрде қос:
List<Map<String, dynamic>> cartItems = [];
List<Map<String, dynamic>> favoriteItems = [];