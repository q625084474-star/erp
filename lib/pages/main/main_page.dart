import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_app/pages/home/home_page.dart';
import 'package:erp_app/pages/purchase/purchase_page.dart';
import 'package:erp_app/pages/sales/sales_page.dart';
import 'package:erp_app/pages/inventory/inventory_page.dart';
import 'package:erp_app/pages/mine/mine_page.dart';
import 'package:erp_app/theme/app_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const InventoryPage(),
    const SalesPage(),
    const MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 24.sp),
                  activeIcon: Icon(Icons.home, size: 24.sp),
                  label: '首页',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined, size: 24.sp),
                  activeIcon: Icon(Icons.inventory_2, size: 24.sp),
                  label: '库存',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined, size: 24.sp),
                  activeIcon: Icon(Icons.shopping_cart, size: 24.sp),
                  label: '销售',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, size: 24.sp),
                  activeIcon: Icon(Icons.person, size: 24.sp),
                  label: '我的',
                ),
              ],
            ),
          ),
        ),
      ),
      // 悬浮扫码按钮（PDA模式）
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 跳转扫码页面
        },
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 28.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
