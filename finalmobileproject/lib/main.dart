// main.dart — แปลงจาก RumaiBadmintonApp.swift + ContentView.swift
//
// Swift Pattern       → Flutter Pattern
// @main App struct    → runApp(MyApp())
// @StateObject        → ChangeNotifierProvider
// TabView             → IndexedStack + custom TabBar
// .ultraThinMaterial  → BackdropFilter / Colors.white.withOpacity(0.85)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'viewmodels/racket_view_model.dart';
import 'screens/racket_selection_screen.dart';
import 'screens/saved_rackets_screen.dart';
import 'screens/community_screen.dart';
import 'screens/guide_screen.dart';
import 'widgets/shared_components.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const RumaiBadmintonApp());
}

// ── RumaiBadmintonApp (= @main App struct) ──
class RumaiBadmintonApp extends StatelessWidget {
  const RumaiBadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RacketViewModel(), // แทน @StateObject var viewModel = RacketViewModel()
      child: MaterialApp(
        title: 'Rumai Badminton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: emeraldColor,
          scaffoldBackgroundColor:
              const Color(0xFFF2F2F7), // systemGroupedBackground
          fontFamily:
              'Sarabun', // รองรับภาษาไทยได้ดี (เพิ่มใน pubspec ถ้าต้องการ)
        ),
        home: const ContentView(),
      ),
    );
  }
}

// ── ContentView (= ContentView.swift) ──
class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  int _selectedTab = 0;

  // แทน TabView { ... .tag(n) }
  static const List<Widget> _screens = [
    RacketSelectionScreen(),
    SavedRacketsScreen(),
    CommunityScreen(),
    GuideScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ── Content (แทน TabView) ──
          IndexedStack(index: _selectedTab, children: _screens),

          // ── Custom Tab Bar (แทน HStack ด้านล่าง ContentView) ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(100), // Capsule shape
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TabBarButton(
                    icon: Icons.search,
                    title: 'ค้นหา',
                    isSelected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                  TabBarButton(
                    icon: Icons.favorite_border,
                    selectedIcon: Icons.favorite,
                    title: 'ไม้โปรด',
                    isSelected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                  TabBarButton(
                    icon: Icons.group_outlined,
                    selectedIcon: Icons.group,
                    title: 'ก๊วน',
                    isSelected: _selectedTab == 2,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                  TabBarButton(
                    icon: Icons.menu_book_outlined,
                    selectedIcon: Icons.menu_book,
                    title: 'คู่มือ',
                    isSelected: _selectedTab == 3,
                    onTap: () => setState(() => _selectedTab = 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
