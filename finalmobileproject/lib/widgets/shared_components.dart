// shared_components.dart — แปลงจาก SharedComponents.swift
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';

/// Header bar ที่ใช้ร่วมกันทุก screen
Widget buildScreenHeader(String title) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    decoration: const BoxDecoration(
      color: Color(0xFFF2F2F7),
    ),
    child: SafeArea(
      bottom: false,
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
    ),
  );
}

class HeroSectionView extends StatelessWidget {
  const HeroSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('DEMO RACKET GUIDE',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: emeraldColor)),
              SizedBox(height: 8),
              Text('เลือกไม้แบดที่เหมาะกับสไตล์การเล่น',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          _glassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ตัวเลขหน้า U ยิ่งมาก ไม้ยิ่งเบา',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 12),
                ...weightData.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(item.u,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: emeraldColor)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.t,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(item.d,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _glassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ความแข็งของก้าน (SHAFT)',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 12),
                const Text('ก้านอ่อน (Flexible)',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const Text('มีสปริงช่วยส่งแรง ตีสบาย เหมาะกับมือใหม่',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                const Divider(height: 16),
                const Text('ก้านแข็ง (Stiff)',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const Text('คอนโทรลแม่นยำ ตบจิก เหมาะสำหรับมือกลางขึ้นไป',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white),
        ),
        child: child,
      );
}

class TabBarButton extends StatelessWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TabBarButton({
    super.key,
    required this.icon,
    this.selectedIcon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: emeraldColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? (selectedIcon ?? icon) : icon,
                  size: 20,
                  color:
                      isSelected ? emeraldColor : Colors.grey.withOpacity(0.6),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? emeraldColor
                        : Colors.grey.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
