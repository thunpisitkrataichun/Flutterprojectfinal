// saved_rackets_screen.dart — แปลงจาก SavedRacketsView.swift
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/racket_view_model.dart';
import '../widgets/card_components.dart';
import '../widgets/shared_components.dart';

class SavedRacketsScreen extends StatelessWidget {
  const SavedRacketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RacketViewModel>(
      builder: (context, vm, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: buildScreenHeader('ไม้ที่บันทึกไว้'),
          ),
          Expanded(
            child: vm.favoriteRackets.isEmpty
                ? const _EmptyFavorites()
                : Container(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: vm.favoriteRackets.length,
                        itemBuilder: (_, i) => RacketCardView(
                          racket: vm.favoriteRackets[i],
                          viewModel: vm,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.heart_broken, size: 40, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'ยังไม่มีไม้ที่บันทึกไว้',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'กดหัวใจที่ไม้แบดที่คุณสนใจ เพื่อเก็บไว้ดูภายหลังได้ที่นี่',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
}
