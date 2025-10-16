import 'package:flutter/material.dart';

import '../chartdata.dart';
import '../product.dart';
import '../recent_activity.dart';

class SampleData {
  static final pages = <String>[
    'Dashboard',
    'Analytics',
    'Products',
    'Orders',
    'Customers',
    'Settings',
    'Profile',
  ];
  static final chartData = <ChartData>[
    ChartData('Mon', 45, 30),
    ChartData('Tue', 56, 40),
    ChartData('Wed', 62, 48),
    ChartData('Thu', 71, 55),
    ChartData('Fri', 68, 60),
    ChartData('Sat', 60, 50),
    ChartData('Sun', 52, 45),
  ];
  static final recentActivity = <RecentActivity>[
    RecentActivity(
      'New Order Received',
      '#ORD-12345',
      '3 min ago',
      Icons.shopping_cart,
      Colors.blue,
    ),
    RecentActivity(
      'Payment Successful',
      '#PAY-67890',
      '15 min ago',
      Icons.payment,
      Colors.green,
    ),
    RecentActivity(
      'User Registration',
      'UID-ABCDE',
      '1 hour ago',
      Icons.person_add,
      Colors.purple,
    ),
    RecentActivity(
      'Shipment Update',
      '#SHP-FGHIJ',
      '3 hours ago',
      Icons.local_shipping,
      Colors.orange,
    ),
    RecentActivity(
      'Review Added',
      '#REV-KLMNO',
      '5 hours ago',
      Icons.rate_review,
      Colors.amber,
    ),
    RecentActivity(
      'Stock Alert',
      'SKU-PQRST',
      '1 day ago',
      Icons.warning,
      Colors.red,
    ),
    RecentActivity(
      'Support Ticket',
      '#TKT-UVWXY',
      '2 days ago',
      Icons.support_agent,
      Colors.cyan,
    ),
  ];
  static final topProducts = <Product>[
    Product(
      'iPhone 12',
      '\$999',
      200,
      'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-r1.jpg',
    ),
    Product(
      'Samsung Galaxy S21',
      '\$799',
      180,
      'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s21-5g-1.jpg',
    ),
    Product(
      'OnePlus 11',
      '\$749',
      130,
      'https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-11-1.jpg',
    ),
    Product(
      'Sony Xperia 1 V',
      '\$1199',
      90,
      'https://fdn2.gsmarena.com/vv/pics/sony/sony-xperia-1-v-1.jpg',
    ),
    Product(
      'Huawei P60 Pro',
      '\$999',
      110,
      'https://fdn2.gsmarena.com/vv/pics/huawei/huawei-p60-pro-1.jpg',
    ),
    Product(
      'Asus ROG Phone 7',
      '\$1099',
      75,
      'https://fdn2.gsmarena.com/vv/pics/asus/asus-rog-phone-7-1.jpg',
    ),
  ];
}
