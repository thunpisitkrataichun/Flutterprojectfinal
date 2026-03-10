// models.dart — แปลงจาก Models.swift

class Racket {
  final String id;
  final String brand;
  final String modelName;
  final double price;
  final String balanceTag;
  final String flex;
  final String description;
  final String playerLevel;
  final String styleTag;
  final String imageName;

  Racket({
    required this.brand,
    required this.modelName,
    required this.price,
    required this.balanceTag,
    required this.flex,
    required this.description,
    required this.playerLevel,
    required this.styleTag,
    required this.imageName,
  }) : id = '$brand-$modelName'; // ใช้ brand+model เป็น unique ID
}

class CourtGroup {
  final String id;
  final String courtName;
  final double lat;
  final double lng;
  final String groupType;
  final String? levelText;
  final String? note;
  final int playersMax;
  final String timeRange;
  final String priceText;
  final String lineGroupUrl;
  final String filterTag;

  CourtGroup({
    required this.courtName,
    required this.lat,
    required this.lng,
    required this.groupType,
    this.levelText,
    this.note,
    required this.playersMax,
    required this.timeRange,
    required this.priceText,
    required this.lineGroupUrl,
    required this.filterTag,
  }) : id = '$courtName-$lat';
}

class WeightGuide {
  final String u;
  final String w;
  final String t;
  final String d;
  const WeightGuide({required this.u, required this.w, required this.t, required this.d});
}

class PlaystyleOption {
  final String value;
  final String title;
  final String iconName; // Flutter ใช้ IconData แทน SF Symbols
  final String description;
  const PlaystyleOption({required this.value, required this.title, required this.iconName, required this.description});
}

class BalanceOption {
  final String value;
  final String title;
  final String shortDesc;
  final String fullDesc;
  const BalanceOption({required this.value, required this.title, required this.shortDesc, required this.fullDesc});
}
