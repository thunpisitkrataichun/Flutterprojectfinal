// racket_view_model.dart — แปลงจาก RacketViewModel.swift
// @ObservableObject → ChangeNotifier
// @Published        → notifyListeners()

import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

class RacketViewModel extends ChangeNotifier {
  // ────────────────────────────────────────────────────────────────
  // State (เทียบกับ @Published ใน Swift)
  // ────────────────────────────────────────────────────────────────
  List<Racket> _recommendedRackets = [];
  bool _isLoading = false;
  String _playstyle = '';
  String _balance = '';
  double _budget = 5000;
  String _budgetString = '5000';
  Set<String> _savedRacketIDs = {}; // ใช้ String ID แทน UUID

  // ────────────────────────────────────────────────────────────────
  // Getters
  // ────────────────────────────────────────────────────────────────
  List<Racket> get recommendedRackets => _recommendedRackets;
  bool get isLoading => _isLoading;
  String get playstyle => _playstyle;
  String get balance => _balance;
  double get budget => _budget;
  String get budgetString => _budgetString;
  Set<String> get savedRacketIDs => _savedRacketIDs;

  // favoriteRackets (computed property เหมือน Swift)
  List<Racket> get favoriteRackets =>
      mockRacketsData.where((r) => _savedRacketIDs.contains(r.id)).toList();

  // ────────────────────────────────────────────────────────────────
  // Setters (notifyListeners แทน @Published)
  // ────────────────────────────────────────────────────────────────
  set playstyle(String v) { _playstyle = v; notifyListeners(); }
  set balance(String v)   { _balance = v;   notifyListeners(); }

  set budget(double v) {
    _budget = v;
    _budgetString = v.toInt().toString();
    notifyListeners();
  }

  set budgetString(String v) {
    _budgetString = v;
    final parsed = double.tryParse(v);
    if (parsed != null && parsed >= 1000 && parsed <= 10000) {
      _budget = parsed;
    }
    notifyListeners();
  }

  // ────────────────────────────────────────────────────────────────
  // toggleFavorite
  // ────────────────────────────────────────────────────────────────
  void toggleFavorite(Racket racket) {
    if (_savedRacketIDs.contains(racket.id)) {
      _savedRacketIDs.remove(racket.id);
    } else {
      _savedRacketIDs.add(racket.id);
    }
    notifyListeners();
  }

  // ────────────────────────────────────────────────────────────────
  // fetchRecommendedRackets
  // แทน DispatchQueue.main.asyncAfter ด้วย Future.delayed
  // ────────────────────────────────────────────────────────────────
  Future<void> fetchRecommendedRackets() async {
    _isLoading = true;
    _recommendedRackets = [];
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    var filtered = List<Racket>.from(mockRacketsData);

    if (_playstyle.isNotEmpty) {
      filtered = filtered.where((r) => r.styleTag == _playstyle).toList();
    }
    if (_balance.isNotEmpty) {
      filtered = filtered.where((r) => r.balanceTag == _balance).toList();
    }
    filtered = filtered.where((r) => r.price <= _budget).toList();

    _recommendedRackets = filtered;
    _isLoading = false;
    notifyListeners();
  }
}
