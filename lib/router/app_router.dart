import 'package:flutter/material.dart';
import 'package:erp_app/pages/splash/splash_page.dart';
import 'package:erp_app/pages/login/login_page.dart';
import 'package:erp_app/pages/main/main_page.dart';
import 'package:erp_app/pages/home/home_page.dart';
import 'package:erp_app/pages/purchase/purchase_page.dart';
import 'package:erp_app/pages/sales/sales_page.dart';
import 'package:erp_app/pages/inventory/inventory_page.dart';
import 'package:erp_app/pages/finance/finance_page.dart';
import 'package:erp_app/pages/mine/mine_page.dart';
import 'package:erp_app/pages/scan/scan_page.dart';

class AppRouter {
  // 路由名称常量
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String home = '/home';
  static const String purchase = '/purchase';
  static const String sales = '/sales';
  static const String inventory = '/inventory';
  static const String finance = '/finance';
  static const String mine = '/mine';
  static const String scan = '/scan';

  // 路由生成
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case scan:
        return MaterialPageRoute(builder: (_) => const ScanPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('未找到路由: ${settings.name}'),
            ),
          ),
        );
    }
  }

  // 路由跳转方法
  static void pushNamed(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pushReplacementNamed(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static void pop(BuildContext context, [Object? result]) {
    Navigator.pop(context, result);
  }
}
