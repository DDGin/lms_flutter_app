import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/providers/navigation_provider.dart';
import 'package:pragmatic_flutter/views/page_content_switcher.dart';
import 'package:pragmatic_flutter/views/widgets/custom_bottom_nav_bar.dart';
import 'package:pragmatic_flutter/views/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import 'views/widgets/custom_app_bar.dart';
import 'views/widgets/side_navigation.dart';
import 'views/widgets/stat_card.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final navProvider = context.watch<NavigationProvider>();
    final dataProvider = context.read<DashboardProvider>();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          bool isDesktop = constraints.maxWidth >= 900;

          return Row(
            children: [
              // Side Navigation (Widget riêng)
              if (!isMobile) SideNavigation(isDesktop: isDesktop),
              Expanded(
                child: Column(
                  children: [
                    // App Bar (Widget riêng)
                    CustomAppBar(
                      scaffoldKey: scaffoldKey,
                      isMobile: isMobile,
                      isTablet: isTablet,
                      isDesktop: isDesktop,
                    ),
                    Expanded(
                      child: Container(
                        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(isMobile ? 12 : 24),
                          child: PageContentSwitcher(
                            isMobile: isMobile,
                            isTablet: isTablet,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // BottomNavigationBar (sử dụng Consumer để lắng nghe selectedIndex)
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const CustomBottomNavBar();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: navProvider.selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Text('New Order'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}
