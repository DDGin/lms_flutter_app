import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pragmatic_flutter/providers/navigation_provider.dart';
import 'package:pragmatic_flutter/providers/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            accountName: const Text("Dao Tien Dung"),
            accountEmail: const Text("dung226dtd@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.w3schools.com/w3css/img_avatar.png',
              ),
            ),
          ),
          // Danh sách menu
          Consumer<NavigationProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(provider.getIcon(index)),
                      title: Text(provider.pages[index]),
                      selected: provider.selectedIndex == index,
                      onTap: () {
                        context.read<NavigationProvider>().setSelectedIndex(
                          index,
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  itemCount: provider.pages.length,
                ),
              );
            },
          ),
          const Divider(),
          // Switch Dark Mode
          SwitchListTile(
            title: const Text("Dark Mode"),
            secondary: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            value: isDarkMode,
            onChanged: (value) {
              context.read<ThemeProvider>().toggleTheme(value);
            },
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
