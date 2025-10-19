import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/providers/navigation_provider.dart';
import 'package:pragmatic_flutter/providers/theme_provider.dart';
import 'package:pragmatic_flutter/views/theme/colors.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.read<NavigationProvider>().currentPageTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 20 : 24,
                  ),
                ),
                Text(
                  "Welcome back, Tien Dung",
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14, // Giảm kích thước cho Desktop
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) ...[
            Container(
              width: isDesktop ? 300 : 200,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: MidnightColors.lightGray,
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
          IconButton(
            onPressed: () {
              /* Hành động thông báo */
            },
            icon: Icon(Icons.notifications_outlined),
          ),
          SizedBox(width: 8),
          // Nút chuyển đổi Dark Mode
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme(!isDarkMode);
            },
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          if (!isMobile) ...[
            SizedBox(width: 16),
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://www.w3schools.com/w3css/img_avatar.png',
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
