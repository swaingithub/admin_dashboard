import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'login_controller.dart';
import '../../core/theme/fx_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Standard Fluxy Pattern: lazyPut the controller for this specific page
    Fluxy.lazyPut(() => LoginController());
    final controller = Fluxy.find<LoginController>();
    
    final breakpoint = ResponsiveEngine.of(context);
    final isMobile = breakpoint.index <= Breakpoint.sm.index;

    return Scaffold(
      backgroundColor: FxColors.mainBackground,
      body: Fx.center(
        child: Fx.box(
          child: Fx.col(
            gap: 0,
            children: [
              Fx.text('Fluxy Dashboard')
                .fontSize(isMobile ? 24 : 28)
                .bold()
                .color(FxColors.textHeading)
                .animate(fade: 0.0, slide: const Offset(0, -10)),
              
              Fx.box().h(8),
              
              Fx.text('Please login to your account')
                .textSm()
                .color(FxColors.textBody)
                .animate(fade: 0.0, slide: const Offset(0, -5), delay: 0.1),
              
              Fx.box().h(32),
              
              _buildLabel('Email Address'),
              Fx.input(
                signal: controller.email,
                placeholder: 'Enter your email',
              ),
              
              Fx.box().h(20),
              
              _buildLabel('Password'),
              Fx.password(
                signal: controller.password,
                placeholder: 'Enter your password',
              ),
              
              Fx.box().h(32),
              
              Fx(() => Fx.box(
                child: Fx.center(
                  child: Fx.text(controller.isLoading.value ? 'Loading...' : 'Login Now')
                    .bold()
                    .color(Colors.white),
                ),
              )
              .h(50)
              .wFull()
              .radius(12)
              .background(controller.isLoading.value ? Colors.grey : FxColors.primary)
              .onTap(() async {
                try {
                  await controller.login();
                } catch (e) {
                  Fx.toast(context, 'Invalid credentials');
                }
              }))
              .animate(fade: 0.0, scale: 0.9, delay: 0.3),
            ],
          ),
        )
        .padding(isMobile ? 24 : 40)
        .w(isMobile ? MediaQuery.of(context).size.width * 0.9 : 450)
        .bg.white
        .rounded(isMobile ? 12 : 24)
        .shadow(blur: 40, offset: const Offset(0, 20), color: Colors.black.withValues(alpha: 0.05)),
      )
    );
  }

  Widget _buildLabel(String label) {
    return Fx.text(label)
      .semiBold()
      .textSm()
      .color(FxColors.textHeading)
      .mb(8);
  }
}
