import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/navigation_provider.dart'; // Import Provider

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Lắng nghe NavigationProvider
    return Consumer<NavigationProvider>(
      builder: (context, navProvider, child) {
        // 2. Định nghĩa danh sách các item bạn muốn hiển thị trên thanh Bottom Nav
        // (Sử dụng 4 mục đầu tiên để tránh quá tải trên mobile)
        final List<BottomNavigationBarItem> bottomNavItems = [
          BottomNavigationBarItem(
            icon: Icon(navProvider.getIcon(0)), // Lấy icon từ Provider
            label: navProvider.pages[0], // Lấy tên trang từ Provider
          ),
          BottomNavigationBarItem(
            icon: Icon(navProvider.getIcon(1)),
            label: navProvider.pages[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(navProvider.getIcon(2)),
            label: navProvider.pages[2],
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More', // Mục 'More' có thể cố định hoặc dẫn đến index 3
          ),
        ];

        return BottomNavigationBar(
          currentIndex: navProvider.selectedIndex.clamp(
            0,
            bottomNavItems.length - 1,
          ),

          onTap: navProvider.setSelectedIndex,

          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue[700],
          items: bottomNavItems,
        );
      },
    );
  }
}
