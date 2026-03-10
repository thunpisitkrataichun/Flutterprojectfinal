// mock_data.dart — แปลงจาก MockData.swift
import 'package:flutter/material.dart';
import '../models/models.dart';

// ────────────────────────────────────────────────────────────────
// Playstyle Options (แทน SF Symbols ด้วย Material Icons)
// ────────────────────────────────────────────────────────────────
const List<PlaystyleOption> playstyleOptions = [
  PlaystyleOption(value: 'All-round',         title: 'All-round', iconName: 'open_with',          description: 'ตีได้ทุกแบบ รุก-รับ'),
  PlaystyleOption(value: 'Fast attack',        title: 'Speed',     iconName: 'bolt',               description: 'เน้นความไว ตัดจบเร็ว'),
  PlaystyleOption(value: 'Power smash',        title: 'Power',     iconName: 'local_fire_department', description: 'ตบหนัก บุกดุดัน'),
  PlaystyleOption(value: 'Control / Defense',  title: 'Control',   iconName: 'gps_fixed',          description: 'วางลูกแม่น เน้นรับ'),
];

// Map iconName → IconData
IconData getPlaystyleIcon(String iconName) {
  switch (iconName) {
    case 'open_with':           return Icons.open_with;
    case 'bolt':                return Icons.bolt;
    case 'local_fire_department': return Icons.local_fire_department;
    case 'gps_fixed':           return Icons.gps_fixed;
    default:                    return Icons.sports_tennis;
  }
}

// ────────────────────────────────────────────────────────────────
// Balance Options
// ────────────────────────────────────────────────────────────────
const List<BalanceOption> balanceOptionsData = [
  BalanceOption(
    value: 'Head-light', title: 'Head-light', shortDesc: 'หัวเบา',
    fullDesc: 'จุดศูนย์ถ่วงอยู่ค่อนไปทางด้ามจับ เหมาะสำหรับสายเล่นหน้าเน็ต...',
  ),
  BalanceOption(
    value: 'Even balance', title: 'Even balance', shortDesc: 'สมดุล',
    fullDesc: 'น้ำหนักกระจายทั่วทั้งไม้ เล่นได้ทุกสไตล์ทั้งหน้าและหลังคอร์ท...',
  ),
  BalanceOption(
    value: 'Head-heavy', title: 'Head-heavy', shortDesc: 'หัวหนัก',
    fullDesc: 'จุดศูนย์ถ่วงอยู่ค่อนไปทางหัวไม้ ช่วยเพิ่ม โมเมนตัมในการเหวี่ยง...',
  ),
];

// ────────────────────────────────────────────────────────────────
// Mock Rackets
// ────────────────────────────────────────────────────────────────
List<Racket> mockRacketsData = [
  Racket(brand: 'YONEX',  modelName: 'Astrox 99 pro',       price: 6500, balanceTag: 'Head-heavy',   flex: 'Extra Stiff', description: 'ไม้บุกก้านแข็งสำหรับเกมเร็ว',          playerLevel: 'Pro',          styleTag: 'Power smash',       imageName: 'racket1'),
  Racket(brand: 'VICTOR', modelName: 'Thruster Ryuga II',    price: 5800, balanceTag: 'Head-heavy',   flex: 'Stiff',       description: 'ตบหนักหน่วง แม่นยำ',                   playerLevel: 'Advanced',     styleTag: 'Power smash',       imageName: 'racket2'),
  Racket(brand: 'LI-NING', modelName: 'Aeronaut 9000C',      price: 6200, balanceTag: 'Even balance', flex: 'Medium',      description: 'ควบคุมทิศทางลูกได้ดีเยี่ยม',           playerLevel: 'Intermediate', styleTag: 'All-round',         imageName: 'racket3'),
  Racket(brand: 'YONEX',  modelName: 'Nanoflare 800',        price: 6800, balanceTag: 'Head-light',   flex: 'Stiff',       description: 'หน้าไม้ไว ดักลูกหน้าเน็ตดีเยี่ยม',     playerLevel: 'Advanced',     styleTag: 'Fast attack',       imageName: 'racket1'),
  Racket(brand: 'VICTOR', modelName: 'DriveX 9X',            price: 5500, balanceTag: 'Even balance', flex: 'Medium',      description: 'รับแน่น วางลูกแม่นยำดั่งจับวาง',        playerLevel: 'Intermediate', styleTag: 'Control / Defense', imageName: 'racket2'),
];

// ────────────────────────────────────────────────────────────────
// Mock Courts
// ────────────────────────────────────────────────────────────────
List<CourtGroup> mockCourtsData = [
  CourtGroup(courtName: 'Everyday badminton',        lat: 13.860, lng: 100.532, groupType: 'ตีชิล',      levelText: 'มือหน้าบ้าน - มือหนักอึ้ง', note: 'ตีกันน่ารัก ไม่ซีเรียส...', playersMax: 27, timeRange: 'ทุกวัน 17:00 - 24:00',    priceText: '70บาท/เกม',        lineGroupUrl: 'https://line.me', filterTag: 'รับมือใหม่'),
  CourtGroup(courtName: 'Smash Buffet (นนทบุรี)',    lat: 13.850, lng: 100.520, groupType: 'บุฟเฟ่ต์',   levelText: 'มือกลาง - มือโปร',           note: 'ตีไม่อั้น 3 ชั่วโมงเต็ม น้ำแข็งฟรี', playersMax: 40, timeRange: 'ส.-อา. 18:00 - 21:00', priceText: 'เหมา 250 บาท',     lineGroupUrl: 'https://line.me', filterTag: 'สายบุฟเฟ่ต์'),
  CourtGroup(courtName: 'Beginner Club',             lat: 13.870, lng: 100.540, groupType: 'สอน+ตีชิล', levelText: 'เพิ่งจับไม้',                note: 'มีคนสอนเบสิกให้ก่อนตีจริงจัง',      playersMax: 15, timeRange: 'พุธ 19:00 - 22:00',    priceText: '150 บาท/คน',       lineGroupUrl: 'https://line.me', filterTag: 'รับมือใหม่'),
];

// ────────────────────────────────────────────────────────────────
// Weight Guide
// ────────────────────────────────────────────────────────────────
const List<WeightGuide> weightData = [
  WeightGuide(u: '3U', w: '85-89g', t: 'สายรุก',      d: 'ตบหนัก ลูกพุ่งแรง เหมาะกับคนแรงแขนดี เน้นเล่นเดี่ยว แต่หนักมากกก'),
  WeightGuide(u: '4U', w: '80-84g', t: 'สายคุมเกม',  d: 'เน้นความคล่องตัว ตบตัดหยอด ทำได้หมด เล่นได้ทั้งเดี่ยวและคู่'),
  WeightGuide(u: '5U', w: '75-79g', t: 'สายตีชิล',   d: 'ความคล่องตัวสูงสุด เล่นคู่สบายๆ ไม่เน้นบุกหนัก'),
];
