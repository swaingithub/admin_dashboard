import 'package:fluxy/fluxy.dart';
import '../../core/auth/auth_controller.dart';

class LoginController {
  final email = flux('admin@fluxy.com');
  final password = flux('password');
  final isLoading = flux(false);

  Future<void> login() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    final auth = Fluxy.find<AuthController>();
    final success = await auth.login(email.value, password.value);
    isLoading.value = false;

    if (success) {
      Fluxy.offAll('/dashboard');
    } else {
      // In a real app, you'd trigger a toast from here or return a status
      throw Exception('Invalid credentials');
    }
  }
}
