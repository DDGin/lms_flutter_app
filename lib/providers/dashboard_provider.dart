import 'package:flutter/material.dart';
import 'package:pragmatic_flutter/views/theme/theme.dart';
import '../models/sample_data.dart';
import '../models/chartdata.dart';
import '../models/recent_activity.dart';
import '../models/product.dart';

class DashboardProvider with ChangeNotifier {
  final List<ChartData> chartData = SampleData.chartData;
  final List<RecentActivity> recentActivity = SampleData.recentActivity;
  final List<Product> topProducts = SampleData.topProducts;
}
