import 'package:fluxy/fluxy.dart';

class MainController {
  final activeRoute = flux('/');
  
  void navigateTo(String route) {
    activeRoute.value = route;
    Fx.to(route, scope: 'dashboard');
  }
}
