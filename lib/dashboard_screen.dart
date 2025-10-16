import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/chart_painter.dart';
import 'package:pragmatic_flutter/product.dart';
import 'package:pragmatic_flutter/recent_activity.dart';
import 'package:pragmatic_flutter/views/book_list_screen.dart';

import 'chartdata.dart';
import 'models/sample_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _pages = SampleData.pages;

  final List<ChartData> _chartData = SampleData.chartData;

  final List<RecentActivity> _recentActivity = SampleData.recentActivity;

  final List<Product> _topProducts = SampleData.topProducts;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(context),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            bool isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 900;
            bool isDesktop = constraints.maxWidth >= 900;
            return Row(
              children: [
                if (!isMobile)
                  Container(
                    width: isDesktop ? 260 : 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _isDarkMode
                            ? [Colors.grey[900]!, Colors.grey[850]!]
                            : [Colors.green[900]!, Colors.blue[700]!],
                      ),
                    ),
                    child: _buildSideNavigation(isDesktop),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _buildAppBar(isMobile, isTablet, isDesktop),
                      Expanded(
                        child: Container(
                          color: _isDarkMode
                              ? Colors.grey[900]
                              : Colors.grey[100],
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(isMobile ? 12 : 24),
                            child: _buildPageContent(
                              isMobile,
                              isTablet,
                              isDesktop,
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
        bottomNavigationBar: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600)
              return BottomNavigationBar(
                currentIndex: _selectedIndex.clamp(0, 3),
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue[700],
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.analytics),
                    label: 'Analytics',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz),
                    label: 'More',
                  ),
                ],
              );
            else
              return SizedBox.shrink();
          },
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: Text('New Order'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
              )
            : null,
      ),
    );
  }

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900]!, Colors.blue[700]!],
              ),
            ),
            accountName: Text("Dao Tien Dung"),
            accountEmail: Text("dung226dtd@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.w3schools.com/w3css/img_avatar.png',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(_getIcon(index)),
                  title: Text(_pages[index]),
                  selected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: _pages.length,
            ),
          ),
          Divider(),
          SwitchListTile(
            title: Text("Dark Mode"),
            secondary: Icon(Icons.dark_mode_outlined),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSideNavigation(bool isDesktop) {
    return Column(
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
          Text("Admin", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
        SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildNavItem(
                icon: _getIcon(index),
                label: _pages[index],
                isSelected: _selectedIndex == index,
                isDesktop: isDesktop,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
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
          onTap: () {
            setState(() {});
          },
        ),
      ],
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

  Widget _buildAppBar(bool isMobile, bool isTablet, bool isDesktop) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
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
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _pages[_selectedIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 20 : 24,
                  ),
                ),
                Text(
                  "Welcome back, Tien Dung",
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 24,
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
                  fillColor: _isDarkMode ? Colors.grey[750] : Colors.grey[200],
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
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

  Widget _buildPageContent(bool isMobile, bool isTablet, bool isDesktop) {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardScreen(isMobile, isTablet, isDesktop);
      case 1:
        return BookListScreen();
      case 2:
        return _buildDefaultScreen();
      default:
        return _buildDefaultScreen();
    }
  }

  Widget _buildDashboardScreen(bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.2 : 1.4,
          children: [
            _buildStatCard(
              "Total Sales",
              "\$25,000",
              Icons.shopping_cart,
              Colors.blue,
              "+5,4%",
              _isDarkMode,
            ),
            _buildStatCard(
              "Visitor",
              "15,000",
              Icons.people,
              Colors.green,
              "+3.2%",
              _isDarkMode,
            ),
            _buildStatCard(
              "Order",
              "1,200",
              Icons.receipt_long,
              Colors.orange,
              "-4.1%",
              _isDarkMode,
            ),
            _buildStatCard(
              "Revenue",
              "\$18,000",
              Icons.attach_money,
              Colors.purple,
              "+6.5%",
              _isDarkMode,
            ),
          ],
        ),
        SizedBox(height: 24),
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildRevenueChart(isMobile, isTablet, isDesktop),
              ),
              SizedBox(width: 16),
              Expanded(flex: 1, child: _buildRecentActivities()),
            ],
          )
        else ...[
          _buildRevenueChart(isMobile, isTablet, isDesktop),
          SizedBox(width: 16),
          _buildRecentActivities(),
        ],
        SizedBox(height: 24),
        _buildTopProduct(isMobile, isTablet, isDesktop),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String change, // e.g., "+15%" or "-3%"
    bool isDarkMode,
  ) {
    // Determine if the change is positive or negative
    final bool isPositive = change.startsWith('+');
    final Color changeColor = isPositive ? Colors.green : Colors.red;
    final IconData trendIcon = isPositive
        ? Icons.arrow_upward
        : Icons.arrow_downward;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Row(
                  children: [
                    Icon(trendIcon, color: changeColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 16,
                        color: changeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 14),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(bool isMobile, bool isTablet, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            height: isMobile ? 200 : 300,
            child: Center(
              child: CustomPaint(
                painter: ChartPainter(_chartData),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ..._recentActivity.map((act) {
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: act.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(act.icon, color: act.color, size: 20),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          act.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          act.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    act.time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProduct(bool isMobile, bool isTablet, bool isDesktop) {
    return Container(
      padding: EdgeInsetsGeometry.all(20),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _topProducts.map((product) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with rounded corners
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.image,
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 100,
                              width: 150,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100,
                              width: 150,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Product Name (Completed)
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Product Price (Completed)
                      Text(
                        product.price,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),

                      const SizedBox(height: 4),

                      // Sales Count (Completed)
                      Text(
                        "${product.sales} sales",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(), // Don't forget to call .toList() on the map result
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultScreen() {
    return Container(
      color: Colors.red,
      child: Center(
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

  IconData _getIcon(int index) {
    final List<IconData> icons = [
      Icons.dashboard_outlined, // For 'Dashboard'
      Icons.analytics_outlined, // For 'Analytics'
      Icons.shopping_bag_outlined, // For 'Products'
      Icons.receipt_long_outlined, // For 'Orders'
      Icons.people_alt_outlined, // For 'Customers'
      Icons.settings_outlined, // For 'Settings'
      Icons.person_outline, // For 'Profile'
    ];
    return icons[index];
  }
}
