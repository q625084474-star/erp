import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_app/providers/user_provider.dart';
import 'package:erp_app/theme/app_theme.dart';
import 'package:erp_app/widgets/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 快捷功能列表
  final List<Map<String, dynamic>> _quickMenus = [
    {'icon': Icons.qr_code_scanner, 'name': '扫码入库', 'color': const Color(0xFF52C41A)},
    {'icon': Icons.qr_code_scanner, 'name': '扫码出库', 'color': const Color(0xFF1890FF)},
    {'icon': Icons.qr_code_scanner, 'name': '扫码盘点', 'color': const Color(0xFFFAAD14)},
    {'icon': Icons.search, 'name': '库存查询', 'color': const Color(0xFF722ED1)},
    {'icon': Icons.add_shopping_cart, 'name': '采购订单', 'color': const Color(0xFF13C2C2)},
    {'icon': Icons.point_of_sale, 'name': '销售订单', 'color': const Color(0xFFEB2F96)},
    {'icon': Icons.receipt_long, 'name': '应收账款', 'color': const Color(0xFFFA8C16)},
    {'icon': Icons.account_balance_wallet, 'name': '应付账款', 'color': const Color(0xFF2F54EB)},
  ];

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().userName;
    
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // TODO: 消息通知
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 用户信息卡片
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 32.sp, color: AppTheme.primaryColor),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '你好，$userName',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '欢迎使用贸易零售ERP',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white70, size: 24.sp),
                ],
              ),
            ),
            
            // 快捷功能
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '快捷功能',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 1,
                    ),
                    itemCount: _quickMenus.length,
                    itemBuilder: (context, index) {
                      final menu = _quickMenus[index];
                      return MenuItem(
                        icon: menu['icon'],
                        name: menu['name'],
                        color: menu['color'],
                        onTap: () {
                          // TODO: 跳转对应页面
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // 待办事项
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '待办事项',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '查看全部 >',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textHint,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildTodoItem('采购订单待审批', 3, const Color(0xFF52C41A)),
                  SizedBox(height: 12.h),
                  _buildTodoItem('销售订单待审批', 5, const Color(0xFF1890FF)),
                  SizedBox(height: 12.h),
                  _buildTodoItem('库存预警', 8, const Color(0xFFFAAD14)),
                ],
              ),
            ),
            
            // 数据概览
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '今日数据',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(child: _buildDataItem('销售额', '¥12,580', const Color(0xFF52C41A))),
                      Container(width: 1, height: 40.h, color: AppTheme.dividerColor),
                      Expanded(child: _buildDataItem('采购额', '¥8,320', const Color(0xFF1890FF))),
                      Container(width: 1, height: 40.h, color: AppTheme.dividerColor),
                      Expanded(child: _buildDataItem('订单数', '28', const Color(0xFFFAAD14))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoItem(String title, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12.sp,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppTheme.textHint,
          ),
        ),
      ],
    );
  }
}
