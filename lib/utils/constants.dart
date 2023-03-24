import 'package:flutter/material.dart';

class TodoPrefs {
  static const String isInitial = 'isInitial';
}

class TodoColor {
  static const Color purple = Color(0xFF554E8F);
  static const Color purpleLight = Color(0xFF7EB6FF);
  static const Color purpleDark = Color(0xFF5F87E7);
  static const Color greenLight = Color(0xFF5DE61A);
  static const Color greenDark = Color(0xFF39A801);
  static const Color personal = Color(0xFFFFD506);
  static const Color work = Color(0xFF1ED102);
  static const Color meeting = Color(0xFFD10263);
  static const Color study = Color(0xFF3044F2);
  static const Color shopping = Color(0xFFF29130);
  static const Color party = Color(0xFF09ACCE);
}

class TodoStyle {
  static const TextStyle entry = TextStyle(fontSize: 22, color: TodoColor.purple, fontWeight: FontWeight.w600);
  static const TextStyle btn = TextStyle(fontSize: 15);
}
class TodoImage {
  static const String onboarding = 'assets/images/onboarding.png';
}