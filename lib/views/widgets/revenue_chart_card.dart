import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../chart_painter.dart';

class RevenueChartCard extends StatelessWidget {
  final bool isMobile;

  const RevenueChartCard({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(16),
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
                    painter: ChartPainter(provider.chartData),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
