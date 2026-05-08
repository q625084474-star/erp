import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_app/providers/user_provider.dart';
import 'package:erp_app/router/app_router.dart';
import 'package:erp_app/theme/app_theme.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final userName = userProvider.userName;
    
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: 设置页面
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 用户信息卡片
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36.r,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.person, size: 40.sp, color: AppTheme.primaryColor),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '点击编辑个人资料',
                          style: TextStyle(fontSize: 12.sp, color: AppTheme.textHint),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 20.sp, color: AppTheme.textHint),
                ],
              ),
            ),
            
            // 功能列表
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.inventory_2_outlined, '我的库存', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.shopping_cart_outlined, '我的订单', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.receipt_long_outlined, '我的审批', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.notifications_outlined, '消息通知', () {}),
                ],
              ),
            ),
            
            // 其他设置
            Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.help_outline, '帮助中心', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.feedback_outlined, '意见反馈', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.info_outline, '关于我们', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.devices_outlined, 'PDA模式', () {}, showSwitch: true),
                ],
              ),
            ),
            
            // 退出登录按钮
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: OutlinedButton(
                onPressed: () => _showLogoutDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.errorColor,
                  side: const BorderSide(color: AppTheme.errorColor),
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('退出登录', style: TextStyle(fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 24.h),
            
            // 版本信息
            Text(
              '版本 V1.0.0',
              style: TextStyle(fontSize: 12.sp, color: AppTheme.textHint),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool showSwitch = false}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: AppTheme.textSecondary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 15.sp, color: AppTheme.textPrimary),
              ),
            ),
            if (showSwitch)
              Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppTheme.primaryColor,
              )
            else
              Icon(Icons.chevron_right, size: 20.sp, color: AppTheme.textHint),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: Divider(height: 1.h, color: AppTheme.dividerColor),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<UserProvider>().logout();
              if (context.mounted) {
                AppRouter.pushAndRemoveUntil(context, AppRouter.login);
              }
            },
            child: const Text('确定', style: TextStyle(color: AppTheme.errorColor)),
          ),
        ],
      ),
    );
  }
}
