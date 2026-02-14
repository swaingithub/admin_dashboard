import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

class ThemeController {
  final isDarkMode = flux(false);
  
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // In a real framework integration, this would update FxTheme
  }
}
