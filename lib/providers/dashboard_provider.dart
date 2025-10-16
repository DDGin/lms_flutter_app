// lib/providers/dashboard_provider.dart
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  int get selectedIndex => _selectedIndex;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setPage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
