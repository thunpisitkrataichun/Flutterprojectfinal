import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rumai_badminton/main.dart';
import 'package:rumai_badminton/viewmodels/racket_view_model.dart';

void main() {
  testWidgets('App launches and shows tab bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => RacketViewModel(),
        child: const MaterialApp(home: ContentView()),
      ),
    );

    // ตรวจสอบว่า Tab Bar แสดงครบ
    expect(find.text('ค้นหา'), findsOneWidget);
    expect(find.text('ไม้โปรด'), findsOneWidget);
    expect(find.text('ก๊วน'), findsOneWidget);
    expect(find.text('คู่มือ'), findsOneWidget);
  });
}
