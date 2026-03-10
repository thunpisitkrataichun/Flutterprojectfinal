// community_screen.dart — แปลงจาก CommunityView.swift
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/card_components.dart';
import '../widgets/shared_components.dart';


class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedFilter = 'ทั้งหมด';
  String _searchText = '';
  final List<String> _filters = ['ทั้งหมด', 'รับมือใหม่', 'สายบุฟเฟ่ต์'];

  List<CourtGroup> get _filteredCourts {
    var result = mockCourtsData;
    if (_selectedFilter != 'ทั้งหมด') {
      result = result.where((c) => c.filterTag == _selectedFilter).toList();
    }
    if (_searchText.isNotEmpty) {
      result = result
          .where((c) => c.courtName.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildScreenHeader('ก๊วนแบดมินตัน'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Search Bar ──
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'พิมพ์ชื่อก๊วนหรือสถานที่...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 13),
                          ),
                          onChanged: (v) => setState(() => _searchText = v),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Filter Chips ──
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((f) {
                      final isSelected = _selectedFilter == f;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = f),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? emeraldColor : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? emeraldColor : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          child: Text(f,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.grey,
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // ── ก๊วนแนะนำ ──
                const Text('ก๊วนแนะนำใกล้ตัวคุณ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 16),
                if (_filteredCourts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('ไม่พบก๊วนที่ค้นหา ลองเปลี่ยนคำค้นหาดูนะครับ',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  )
                else
                  ...(_filteredCourts.map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CourtGroupCard(group: c),
                      ))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
