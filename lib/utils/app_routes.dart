import 'package:flutter/material.dart';
import 'package:flutter_forward_session/views/login_screen.dart';
import 'package:flutter_forward_session/views/signup_screen.dart';
import 'package:flutter_forward_session/views/user_screen.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case "/signup":
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case '/user-screen':
        return MaterialPageRoute(builder: (context) => UserScreen());
    }
    return null;
  }
}
