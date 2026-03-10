// form_components.dart — แปลงจาก FormComponents.swift
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../viewmodels/racket_view_model.dart';

// ────────────────────────────────────────────────────────────────
// PlaystylePickerView
// LazyVGrid → GridView / Wrap
// @Binding var selectedStyle → callback
// ────────────────────────────────────────────────────────────────
class PlaystylePickerView extends StatelessWidget {
  final String selectedStyle;
  final ValueChanged<String> onStyleChanged;
  const PlaystylePickerView(
      {super.key, required this.selectedStyle, required this.onStyleChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('สไตล์การเล่นหลัก',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: playstyleOptions.map((option) {
            final isSelected = selectedStyle == option.value;
            return GestureDetector(
              onTap: () {
                final newVal =
                    selectedStyle == option.value ? '' : option.value;
                onStyleChanged(newVal);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? emeraldColor.withOpacity(0.05)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? emeraldColor
                        : Colors.grey.withOpacity(0.2),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: emeraldColor.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? emeraldColor
                            : emeraldColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        getPlaystyleIcon(option.iconName),
                        size: 20,
                        color: isSelected ? Colors.white : emeraldColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(option.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? emeraldColor : Colors.black87,
                        )),
                    Text(option.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? emeraldColor.withOpacity(0.8)
                              : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────
// BalancePickerView
// rotationDegree → AnimationController / Transform.rotate
// ────────────────────────────────────────────────────────────────
class BalancePickerView extends StatefulWidget {
  final RacketViewModel viewModel;
  const BalancePickerView({super.key, required this.viewModel});

  @override
  State<BalancePickerView> createState() => _BalancePickerViewState();
}

class _BalancePickerViewState extends State<BalancePickerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnim;
  double _targetAngle = 90 * (3.14159 / 180); // radians

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _rotationAnim =
        Tween<double>(begin: _targetAngle, end: _targetAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectBalance(String value) {
    final isTogglingOff = widget.viewModel.balance == value;
    widget.viewModel.balance = isTogglingOff ? '' : value;

    double newAngle;
    if (isTogglingOff) {
      newAngle = 90;
    } else {
      switch (value) {
        case 'Head-light':
          newAngle = 30;
          break;
        case 'Even balance':
          newAngle = 75;
          break;
        case 'Head-heavy':
          newAngle = 115;
          break;
        default:
          newAngle = 90;
      }
    }

    final startAngle = _rotationAnim.value;
    final endAngle = newAngle * (3.14159 / 180);

    _rotationAnim = Tween<double>(begin: startAngle, end: endAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ฟีลน้ำหนักหัวไม้ที่ชอบ',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 16),

        // ── ปุ่ม 3 ตัว ──
        Row(
          children: balanceOptionsData.map((option) {
            final isSelected = widget.viewModel.balance == option.value;
            return Expanded(
              child: GestureDetector(
                onTap: () => _selectBalance(option.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? emeraldColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? emeraldColor
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(option.shortDesc,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white70 : Colors.grey,
                          )),
                      Text(option.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: isSelected ? Colors.white : Colors.black87,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // ── รูปไม้หมุน (แทน ZStack + Image("racket1_rotate")) ──
        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Colors.grey.withOpacity(0.1), style: BorderStyle.solid),
          ),
          child: AnimatedBuilder(
            animation: _rotationAnim,
            builder: (_, child) => Transform.rotate(
              angle: _rotationAnim.value,
              child: child,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/images/racket1_rotate.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.sports_tennis,
                    size: 80, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────
// BudgetPickerView
// Slider + TextField เหมือน Swift ตรงๆ
// ────────────────────────────────────────────────────────────────
class BudgetPickerView extends StatelessWidget {
  final RacketViewModel viewModel;
  const BudgetPickerView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('งบประมาณต่อไม้ (บาท)',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: emeraldColor,
                  thumbColor: emeraldColor,
                  inactiveTrackColor: emeraldColor.withOpacity(0.2),
                ),
                child: Slider(
                  value: viewModel.budget.clamp(1000, 10000),
                  min: 1000,
                  max: 10000,
                  divisions: 90,
                  onChanged: (v) => viewModel.budget = v,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // TextField สำหรับพิมพ์งบตรงๆ
            SizedBox(
              width: 70,
              child: _BudgetTextField(viewModel: viewModel),
            ),
          ],
        ),
      ],
    );
  }
}

class _BudgetTextField extends StatefulWidget {
  final RacketViewModel viewModel;
  const _BudgetTextField({required this.viewModel});

  @override
  State<_BudgetTextField> createState() => _BudgetTextFieldState();
}

class _BudgetTextFieldState extends State<_BudgetTextField> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.viewModel.budgetString);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync slider → text field
    final newText = widget.viewModel.budgetString;
    if (_ctrl.text != newText && !_ctrl.selection.isValid) {
      _ctrl.text = newText;
    }
    return TextField(
      controller: _ctrl,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'ระบุงบ',
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
      ),
      onChanged: (v) => widget.viewModel.budgetString = v,
    );
  }
}
