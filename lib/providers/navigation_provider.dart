import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  static final _pages = <String>[
    'Dashboard',
    'Analytics',
    'Products',
    'Orders',
    'Customers',
    'Settings',
    'Profile',
  ];

  List<String> get pages => _pages;

  String get currentPageTitle {
    if (_selectedIndex >= 0 && _selectedIndex < _pages.length) {
      return _pages[_selectedIndex];
    }
    return "Error: Unknown Page";
  }

  static final List<IconData> _icons = [
    Icons.dashboard_outlined,
    Icons.analytics_outlined,
    Icons.shopping_bag_outlined,
    Icons.receipt_long_outlined,
    Icons.people_alt_outlined,
    Icons.settings_outlined,
    Icons.person_outline,
  ];

  IconData getIcon(int index) {
    if (index >= 0 && index < _icons.length) {
      return _icons[index];
    }
    return Icons.error_outline;
  }

  void setSelectedIndex(int index) {
    if (index >= 0 && index < _pages.length && _selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}
