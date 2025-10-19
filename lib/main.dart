import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_layout.dart';

import 'package:pragmatic_flutter/providers/dashboard_provider.dart';
import 'package:pragmatic_flutter/providers/navigation_provider.dart';
import 'package:pragmatic_flutter/providers/theme_provider.dart'; // Đã tách theme

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. ThemeProvider quản lý ThemeMode và ThemeData
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // 2. Các Providers quản lý trạng thái màn hình
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const MyApp(), // Chuyển MyApp thành con của MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final themeMode = themeProvider.themeMode;

        return MaterialApp(
          title: 'LMS Midnight',
          debugShowCheckedModeBanner: false,
          theme: ThemeProvider.lightTheme,
          darkTheme: ThemeProvider.darkTheme,
          themeMode: themeMode,

          home: const AppLayout(),
        );
      },
    );
  }
}
