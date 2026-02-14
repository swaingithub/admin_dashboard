import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../../core/theme/fx_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String percent;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percent,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Fx.box(
      child: Fx.col(
        gap: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Fx.row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Fx.text(title)
                .semiBold()
                .textSm()
                .color(FxColors.textHeading),
              Fx.icon(icon, color: Colors.grey, size: 20),
            ],
          ),
          Fx.col(
            gap: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Fx.text(value)
                .bold()
                .fontSize(24)
                .color(FxColors.textHeading),
              Fx.text('$percent from last month')
                .fontSize(12)
                .color(Colors.grey),
            ],
          ),
        ],
      ),
    )
    .p(24)
    .background(Colors.white)
    .rounded(20)
    .shadowSmall();
  }
}
