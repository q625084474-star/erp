import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_app/router/app_router.dart';
import 'package:erp_app/providers/user_provider.dart';
import 'package:erp_app/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // 初始化用户信息
    await context.read<UserProvider>().init();
    
    // 延迟跳转
    await Future.delayed(const Duration(seconds: 2));
    
    // 判断是否已登录
    final isLoggedIn = context.read<UserProvider>().isLoggedIn;
    if (isLoggedIn) {
      AppRouter.pushAndRemoveUntil(context, AppRouter.main);
    } else {
      AppRouter.pushAndRemoveUntil(context, AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.inventory_2_rounded,
                size: 60.sp,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 24.h),
            // 应用名称
            Text(
              '贸易零售ERP',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '移动办公 · 高效管理',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 60.h),
            // 加载指示器
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
