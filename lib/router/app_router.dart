import 'package:flutter/material.dart';
import 'package:task/screen/home/home_screen.dart';
import 'package:task/screen/last_login/last_login_screen.dart';
import 'package:task/screen/login/login_screen.dart';
import 'package:task/screen/splash_screen/splash_screen.dart';
import 'route_names.dart';

class AppRouter {
  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.lastLogin:
        return MaterialPageRoute(builder: (_) => const LastLoginScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
