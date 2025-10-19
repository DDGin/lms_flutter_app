import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pragmatic_flutter/providers/dashboard_provider.dart';

import '../widgets/recent_activities_card.dart';
import '../widgets/revenue_chart_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/top_products_card.dart'; // Data Provider

class ReportContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const ReportContent({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DashboardProvider>();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.2 : 1.4,
          children: [
            StatCard(
              title: "Total Sales",
              value: "\$25,000",
              icon: Icons.shopping_cart,
              color: Colors.blue,
              change: "+5,4%",
              isDarkMode: isDarkMode,
            ),
            StatCard(
              title: "Visitor",
              value: "15,000",
              icon: Icons.people,
              color: Colors.green,
              change: "+3.2%",
              isDarkMode: isDarkMode,
            ),
            StatCard(
              title: "Order",
              value: "1,200",
              icon: Icons.receipt_long,
              color: Colors.orange,
              change: "-4.1%",
              isDarkMode: isDarkMode,
            ),
            StatCard(
              title: "Revenue",
              value: "\$18,000",
              icon: Icons.attach_money,
              color: Colors.purple,
              change: "+6.5%",
              isDarkMode: isDarkMode,
            ),
          ],
        ),

        SizedBox(height: 24),
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: RevenueChartCard(isMobile: isMobile)),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: RecentActivitiesCard()),
            ],
          )
        else ...[
          RevenueChartCard(isMobile: isMobile),
          const SizedBox(width: 16),
          RecentActivitiesCard(),
        ],
        const SizedBox(height: 24),
        TopProductsCard(),
      ],
    );
  }
}
