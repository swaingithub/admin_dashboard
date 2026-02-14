import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'widgets/stat_card.dart';
import 'widgets/activity_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveEngine.of(context);
    final isMobile = breakpoint.index <= Breakpoint.sm.index;
    final isTablet = breakpoint.index <= Breakpoint.md.index;

    return Fx.scroll(
      child: Fx.col(
        gap: 32,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat Cards Grid
          if (isMobile)
            Fx.col(
              gap: 20,
              children: _buildStatCards(),
            )
          else
            Fx.row(
              gap: 20,
              children: Fx.stagger(
                _buildStatCards(),
                interval: 0.1,
              ).map((c) => c.expand()).toList(),
            ),
          
          // Charts Section
          if (isTablet)
            Fx.col(
              gap: 32,
              children: [
                _buildMainChart(450),
                _buildRecentSales(450),
              ],
            )
          else
            Fx.row(
              gap: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Fx.expand(flex: 2, child: _buildMainChart(450)),
                Fx.expand(child: _buildRecentSales(450)),
              ],
            ),
        ],
      ).p(24),
    );
  }

  List<Widget> _buildStatCards() {
    return [
      const StatCard(
        title: 'Total Revenue',
        value: '\$45,231.89',
        percent: '+20.1%',
        icon: Icons.attach_money,
        color: Color(0xFF10B981),
      ).animate(fade: 0.0, slide: const Offset(0, 20)),
      const StatCard(
        title: 'Active Users',
        value: '2,350',
        percent: '+180.1%',
        icon: Icons.people_outline,
        color: Colors.blue,
      ).animate(fade: 0.0, slide: const Offset(0, 20)),
      const StatCard(
        title: 'Sales',
        value: '+12,234',
        percent: '+19%',
        icon: Icons.credit_card,
        color: Colors.orange,
      ).animate(fade: 0.0, slide: const Offset(0, 20)),
      const StatCard(
        title: 'Active Now',
        value: '+573',
        percent: '+201',
        icon: Icons.show_chart,
        color: Colors.purple,
      ).animate(fade: 0.0, slide: const Offset(0, 20)),
    ];
  }

  Widget _buildMainChart(double height) {
    return Fx.box(
      child: Fx.col(
        gap: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Fx.text('Performance Overview').bold().fontSize(18),
          Fx.text('Revenue growth over the last 30 days').color(Colors.grey).textSm(),
          Fx.expand(child: const ActivityChart()),
        ],
      ),
    )
    .h(height)
    .p(24)
    .bg.white
    .rounded(20)
    .shadowSmall()
    .animate(fade: 0.0, scale: 0.95);
  }

  Widget _buildRecentSales(double height) {
    return Fx.box(
      child: Fx.col(
        gap: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Fx.text('Recent Sales').bold().fontSize(18),
          Fx.expand(
            child: SingleChildScrollView(
              child: Fx.col(
                gap: 20,
                children: List.generate(5, (index) {
                  final names = ['Olivia Martin', 'Jackson Lee', 'Isabella Nguyen', 'William Kim', 'Sofia Davis'];
                  return Fx.row(
                    gap: 12,
                    children: [
                      Fx.avatar(fallback: names[index][0], size: FxAvatarSize.sm),
                      Fx.expand(child: Fx.text(names[index]).bold().textSm()),
                      Fx.text('+\$1,999.00').bold().textSm(),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    )
    .h(height)
    .p(24)
    .bg.white
    .rounded(20)
    .shadowSmall()
    .animate(fade: 0.0, scale: 0.95);
  }
}
