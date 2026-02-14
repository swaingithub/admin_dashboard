import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../../core/theme/fx_colors.dart';
import '../../../core/auth/auth_controller.dart';
import '../main_controller.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Fx.box(
      child: Fx.col(
        gap: 0,
        children: [
          Fx.box().h(40),
          // Logo
          Fx.row(
            gap: 12,
            children: [
              Fx.box(
                child: Fx.icon(Icons.flash_on, color: Colors.white, size: 24),
              )
              .p(8)
              .rounded(12)
              .background(FxColors.primary),
              
              Fx.text('FLUXY')
                .bold()
                .fontSize(22)
                .color(Colors.white),
            ],
          ).px(24),
          
          Fx.box().h(40),
          
          Fx.col(
            gap: 8,
            children: [
              const _SidebarNavItem(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                route: '/',
              ),
              const _SidebarNavItem(
                icon: Icons.table_chart_outlined,
                label: 'Invoices',
                route: '/tables',
              ),
              const _SidebarNavItem(
                icon: Icons.bar_chart_outlined,
                label: 'Analytics',
                route: '/analytics',
              ),
              const _SidebarNavItem(
                icon: Icons.people_outline,
                label: 'Users',
                route: '/users',
              ),
            ],
          ).px(16),
          
          Fx.expand(child: Fx.box()),
          
           Fx.box(
             onTap: () {
               Fx.toggleTheme();
             },
             child: Fx.row(
               gap: 16,
               children: [
                 Fx.icon(Icons.brightness_6_outlined, color: Colors.white, size: 22),
                 Fx.text('Toggle Theme').semiBold().color(Colors.white),
               ],
             ).p(12),
          ).mx(16).rounded(12).onHover((s) => s.bg(Colors.white.withValues(alpha: 0.05))),
          
          Fx.box().h(8),
          
          const _SidebarNavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            route: '/settings',
          ).px(16),
          
          Fx.box(
            child: const Divider(color: Colors.white10, height: 1),
          ).py(16).px(24),
          
          // Logout Item
          Fx.box(
            onTap: () => Fluxy.find<AuthController>().logout(),
            child: Fx.row(
              gap: 16,
              children: [
                Fx.icon(Icons.logout, color: Colors.redAccent, size: 22),
                Fx.text('Logout')
                  .semiBold()
                  .color(Colors.redAccent),
              ],
            ).p(12),
          )
          .mx(16)
          .rounded(12)
          .onHover((s) => s.bg(Colors.redAccent.withValues(alpha: 0.1))),
          
          Fx.box().h(24),
        ],
      ),
    )
    .w(280)
    .background(FxColors.sidebarBackground);
  }
}

class _SidebarNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _SidebarNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Fx(() {
      final controller = Fluxy.find<MainController>();
      final activeRoute = controller.activeRoute.value;
      final isSelected = activeRoute == route;
      
      return Fx.box(
        onTap: () => controller.navigateTo(route),
        child: Fx.row(
          gap: 16,
          children: [
            Fx.icon(
              icon,
              color: isSelected ? Colors.white : Colors.white60,
              size: 22,
            ),
            Fx.text(label)
              .semiBold()
              .color(isSelected ? Colors.white : Colors.white60),
          ],
        ).p(12),
      )
      .rounded(12)
      .background(isSelected ? FxColors.primary : Colors.transparent)
      .onHover((s) => isSelected ? s : s.bg(Colors.white.withValues(alpha: 0.05)));
    });
  }
}
