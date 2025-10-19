import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/models/sample_data.dart';
import 'package:pragmatic_flutter/providers/dashboard_provider.dart';
import 'package:pragmatic_flutter/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class SideNavigation extends StatelessWidget {
  final bool isDesktop;

  const SideNavigation({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final pages = provider.pages;
        return Container(
          width: isDesktop ? 260 : 80,
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: isDesktop ? 40 : 25,
                  backgroundImage: NetworkImage(
                    'https://www.w3schools.com/howto/img_avatar.png',
                  ),
                ),
              ),
              if (isDesktop) ...[
                SizedBox(height: 10),
                Text(
                  'Tien Dung',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Admin",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
              SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return _buildNavItem(
                      icon: SampleData.icons[index],
                      label: pages[index],
                      isSelected: provider.selectedIndex == index,
                      isDesktop: isDesktop,
                      onTap: () {
                        context.read<NavigationProvider>().setSelectedIndex(
                          index,
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(color: Colors.white24),
              _buildNavItem(
                icon: Icons.settings,
                label: "Setting",
                isSelected: false,
                isDesktop: isDesktop,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDesktop,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 16 : 8,
          horizontal: 12,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isDesktop) ...[
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
