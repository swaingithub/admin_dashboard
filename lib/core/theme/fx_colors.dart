import 'package:flutter/material.dart';

class FxColors {
  // Dark Palette (Enterprise look)
  static const Color sidebarBackground = Color(0xFF0F172A);
  static const Color mainBackground = Color(0xFFF8FAFC);
  static const Color sidebarItemActive = Color(0xFF1E293B);
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color accent = Color(0xFF8B5CF6); // Violet
  
  static const Color textBody = Color(0xFF475569);
  static const Color textHeading = Color(0xFF1E293B);
  static const Color white = Colors.white;
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
