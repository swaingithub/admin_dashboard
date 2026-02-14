import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../core/theme/fx_colors.dart';
import 'widgets/sidebar.dart';
import 'widgets/navbar.dart';
import '../dashboard/dashboard_screen.dart';
import '../tables/data_table_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveEngine.of(context).index <= Breakpoint.sm.index;

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      drawer: isMobile ? const Sidebar() : null,
      body: Fx.row(
        children: [
          // Sidebar (Fixed on desktop, hidden on mobile)
          if (!isMobile) const Sidebar(),
          
          // Main Content
          Fx.expand(
            child: Fx.col(
              children: [
                const Navbar(),
                Fx.expand(
                  child: Fx.box(
                    child: FxOutlet(
                      scope: 'dashboard',
                      initialRoute: '/',
                      routes: [
                        FxRoute(
                          path: '/',
                          builder: (params, args) => const DashboardScreen(),
                        ),
                        FxRoute(
                          path: '/tables',
                          builder: (params, args) => const DataTableScreen(),
                        ),
                        FxRoute(
                          path: '/analytics',
                          builder: (params, args) => const Center(child: Text('Analytics Coming Soon')),
                        ),
                        FxRoute(
                          path: '/users',
                          builder: (params, args) => const Center(child: Text('Users Management')),
                        ),
                        FxRoute(
                          path: '/settings',
                          builder: (params, args) => const Center(child: Text('Settings Screen')),
                        ),
                      ],
                    ),
                  ).background(FxColors.mainBackground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
