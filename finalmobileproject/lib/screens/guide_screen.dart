// guide_screen.dart — แปลงจาก GuideView.swift
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/shared_components.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  static const _youtubeId = '8MP7Ou6AwxM';

  Future<void> _openYouTube() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=$_youtubeId');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildScreenHeader('คู่มือสำหรับมือใหม่'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
            child: Column(
              children: [
                // ── HeroSectionView ──
                const HeroSectionView(),
                const SizedBox(height: 24),

                // ── YouTube Card ──
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03), blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('วิดีโอสอนดูสเปคไม้แบด',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      const SizedBox(height: 12),
                      // ── Thumbnail ──
                      GestureDetector(
                        onTap: _openYouTube,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                'https://img.youtube.com/vi/$_youtubeId/hqdefault.jpg',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 200,
                                  color: Colors.black87,
                                  child: const Icon(Icons.play_circle_fill,
                                      size: 60, color: Colors.white70),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              const Icon(Icons.play_circle_fill,
                                  size: 60, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "แตะเพื่อดูคลิป 'สอนเลือกไม้แบดสำหรับมือใหม่' ผ่านแอป YouTube",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
