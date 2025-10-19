import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/dashboard_provider.dart';
import 'contents/report_content.dart';

// Import các widget cho từng trang
// import 'dashboard_content.dart'; // Widget cho case 0
// import '../book_list_screen.dart'; // Widget cho case 1 (Nếu có)

class PageContentSwitcher extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const PageContentSwitcher({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<NavigationProvider, int>(
      selector: (_, navProvider) => navProvider.selectedIndex,
      builder: (context, selectedIndex, child) {
        switch (selectedIndex) {
          case 0:
            return ReportContent(
              isMobile: isMobile,
              isTablet: isTablet,
              isDesktop: isDesktop,
            );
          case 1:
            // Ví dụ: Trang Analytics đã tách
            return _buildDefaultScreen();
          case 2:
            // Ví dụ: Trang Products
            return _buildDefaultScreen();
          default:
            return _buildDefaultScreen();
        }
      },
    );
  }

  Widget _buildDefaultScreen() {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction),
            SizedBox(height: 20),
            Text(
              "Page Under Construction",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
