// racket_selection_screen.dart — แปลงจาก RacketSelectionView.swift
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/racket_view_model.dart';
import '../widgets/card_components.dart';
import '../widgets/form_components.dart';
import '../widgets/shared_components.dart';

class RacketSelectionScreen extends StatelessWidget {
  const RacketSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RacketViewModel>(
      builder: (context, vm, _) => Column(
        children: [
          buildScreenHeader('ค้นหาไม้แบด'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ระบุสเปคที่คุณตามหา',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        PlaystylePickerView(
                          selectedStyle: vm.playstyle,
                          onStyleChanged: (v) => vm.playstyle = v,
                        ),
                        const SizedBox(height: 24),
                        BalancePickerView(viewModel: vm),
                        const SizedBox(height: 24),
                        BudgetPickerView(viewModel: vm),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: vm.isLoading ? null : vm.fetchRecommendedRackets,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              vm.isLoading ? 'กำลังค้นหา...' : 'ดูไม้ที่เหมาะกับฉัน',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (vm.recommendedRackets.isNotEmpty)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('ผลลัพธ์ไม้แบดที่เหมาะกับคุณ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                  const SizedBox(height: 12),
                  RacketResultSectionView(viewModel: vm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
