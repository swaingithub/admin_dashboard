import 'package:fluxy/fluxy.dart';

class AuthController {
  final isLoggedIn = flux(false);
  final user = flux<Map<String, String>?>(null);

  Future<bool> login(String email, String password) async {
    // Simulated API Call
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'admin@fluxy.com' && password == 'password') {
      isLoggedIn.value = true;
      user.value = {
        'name': 'Fluxy Admin',
        'email': 'admin@fluxy.com',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Fluxy',
      };
      return true;
    }
    return false;
  }

  void logout() {
    isLoggedIn.value = false;
    user.value = null;
    Fluxy.offAll('/'); // Go to login if logged out
  }
}
