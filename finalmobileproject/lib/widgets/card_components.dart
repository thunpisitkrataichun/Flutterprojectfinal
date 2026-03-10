// card_components.dart — แปลงจาก CardComponents.swift
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../models/models.dart';
import '../viewmodels/racket_view_model.dart';

// ────────────────────────────────────────────────────────────────
// CourtGroupCard — แทน Map() ของ SwiftUI ด้วย flutter_map
// ────────────────────────────────────────────────────────────────
class CourtGroupCard extends StatelessWidget {
  final CourtGroup group;
  const CourtGroupCard({super.key, required this.group});

  Future<void> _openMaps() async {
    final uri =
        Uri.parse('https://maps.google.com/?q=${group.lat},${group.lng}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openLine() async {
    final uri = Uri.parse(group.lineGroupUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── แผนที่ (flutter_map แทน MapKit) ──
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: SizedBox(
              height: 160,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(group.lat, group.lng),
                  initialZoom: 15,
                  interactionOptions:
                      const InteractionOptions(flags: InteractiveFlag.none),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.rumai.badminton',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(group.lat, group.lng),
                        child: const Icon(Icons.location_pin,
                            color: emeraldColor, size: 36),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── ข้อมูลก๊วน ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ก๊วนแบดมินตัน',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 4),
                Text(group.courtName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _tagChip('🏸 ${group.groupType}'),
                    _tagChip('รับทั้งหมด ${group.playersMax} คน'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _infoColumn('เวลา', group.timeRange),
                    const SizedBox(width: 16),
                    _infoColumn('ค่าสนาม', group.priceText),
                  ],
                ),
                const SizedBox(height: 8),
                if (group.note != null)
                  Text('"${group.note}"',
                      style: const TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _openLine,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: emeraldColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('ขอจอยก๊วน',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: _openMaps,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      child: const Text('🗺️', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      );

  Widget _infoColumn(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(value,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      );
}

// ────────────────────────────────────────────────────────────────
// RacketCardView — แปลงตรงตัว
// ────────────────────────────────────────────────────────────────
class RacketCardView extends StatelessWidget {
  final Racket racket;
  final RacketViewModel viewModel;
  const RacketCardView(
      {super.key, required this.racket, required this.viewModel});

  Future<void> _openShopee() async {
    final query =
        Uri.encodeQueryComponent('${racket.brand} ${racket.modelName}');
    final uri = Uri.parse('https://shopee.co.th/search?keyword=$query');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isFav = viewModel.savedRacketIDs.contains(racket.id);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── รูปภาพ + หัวใจ ──
          Stack(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/${racket.imageName}.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                          Icons.sports_tennis,
                          size: 60,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(racket.styleTag,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => viewModel.toggleFavorite(racket),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1), blurRadius: 2)
                      ],
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFav ? Colors.red : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── ชื่อและแบรนด์ ──
          Text(racket.brand.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Text(racket.modelName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text('${racket.balanceTag} · ${racket.flex}',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Text('฿${racket.price.toInt()}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
          const SizedBox(height: 6),

          // ── ปุ่ม Shopee ──
          GestureDetector(
            onTap: _openShopee,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('เช็คราคาใน Shopee',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                  SizedBox(width: 4),
                  Icon(Icons.shopping_cart, size: 12, color: Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────
// RacketResultSectionView
// ────────────────────────────────────────────────────────────────
class RacketResultSectionView extends StatelessWidget {
  final RacketViewModel viewModel;
  const RacketResultSectionView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: const [
            CircularProgressIndicator(color: emeraldColor),
            SizedBox(height: 12),
            Text('กำลังเฟ้นหาไม้สำหรับคุณ...',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      );
    }

    if (viewModel.recommendedRackets.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.search, size: 40, color: Colors.grey),
            SizedBox(height: 12),
            Text('ไม่พบไม้ที่ตรงกับเงื่อนไข',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: viewModel.recommendedRackets.length,
      itemBuilder: (_, i) => RacketCardView(
          racket: viewModel.recommendedRackets[i], viewModel: viewModel),
    );
  }
}
