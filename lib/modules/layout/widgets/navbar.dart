import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../../core/theme/fx_colors.dart';
import '../../../core/auth/auth_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveEngine.of(context);
    final isMobile = breakpoint.index <= Breakpoint.sm.index;
    final isTablet = breakpoint.index <= Breakpoint.md.index;

    return Fx.box(
      child: Fx.row(
        gap: isMobile ? 12 : 24,
        children: [
          if (isMobile)
            Fx.icon(Icons.menu, color: FxColors.primary, onTap: () {
              Scaffold.of(context).openDrawer();
            }),
            
          Fx.text('Overview')
            .fontSize(isMobile ? 16 : 18)
            .bold()
            .color(FxColors.textHeading),
            
          Fx.expand(child: Fx.box()),
          
          // Search Bar (Hidden or small on mobile)
          if (!isMobile)
            Fx.box(
              child: Fx.row(
                gap: 8,
                children: [
                  Fx.icon(Icons.search, color: Colors.grey, size: 20),
                  Fx.text('Search...').color(Colors.grey).textSm(),
                ],
              ).px(12),
            )
            .w(isTablet ? 150 : 300)
            .h(40)
            .background(const Color(0xFFF1F5F9))
            .rounded(10),
          
          if (isMobile)
             Fx.icon(Icons.search, color: FxColors.textBody, size: 22),

          Fx.icon(Icons.notifications_none_outlined, color: FxColors.textBody),
          
          // User Profile
          Fx(() {
            final auth = Fluxy.find<AuthController>();
            final user = auth.user.value;
            return Fx.row(
              gap: 12,
              children: [
                if (!isMobile)
                  Fx.col(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Fx.text(user?['name'] ?? 'Guest').bold().textSm(),
                      Fx.text('Administrator').color(Colors.grey).fontSize(12),
                    ],
                  ),
                Fx.avatar(
                  image: user?['avatar'],
                  size: FxAvatarSize.sm,
                ),
              ],
            );
          }),
        ],
      ).px(24),
    )
    .h(isMobile ? 60 : 70)
    .background(Colors.white)
    .shadow(color: const Color(0xFFF1F5F9), blur: 0, offset: const Offset(0, 1));
  }
}
