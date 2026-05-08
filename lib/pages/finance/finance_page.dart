import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_app/theme/app_theme.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('财务管理'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 财务概览
            Container(
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFinanceItem('应收账款', '¥58,200.00', Colors.white),
                      Container(width: 1, height: 50.h, color: Colors.white24),
                      _buildFinanceItem('应付账款', '¥32,500.00', Colors.white),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFinanceItem('本月销售额', '¥128,500.00', Colors.white),
                      Container(width: 1, height: 50.h, color: Colors.white24),
                      _buildFinanceItem('本月采购额', '¥86,300.00', Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            
            // 功能菜单
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
                    '常用功能',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMenuButton(Icons.receipt_long_outlined, '应收管理', const Color(0xFF52C41A)),
                      _buildMenuButton(Icons.account_balance_wallet_outlined, '应付管理', const Color(0xFF1890FF)),
                      _buildMenuButton(Icons.attach_money_outlined, '费用管理', const Color(0xFFFAAD14)),
                      _buildMenuButton(Icons.bar_chart_outlined, '财务报表', const Color(0xFF722ED1)),
                    ],
                  ),
                ],
              ),
            ),
            
            // 应收账款列表
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
                        '应收账款',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '查看全部 >',
                        style: TextStyle(fontSize: 14.sp, color: AppTheme.textHint),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildReceivableItem('客户A', '¥12,500.00', '2026-05-15'),
                  _buildReceivableItem('客户B', '¥8,800.00', '2026-05-20'),
                  _buildReceivableItem('客户C', '¥15,200.00', '2026-05-25'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: color.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget _buildMenuButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // TODO: 跳转对应功能
      },
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: AppTheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivableItem(String customer, String amount, String date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '到期日: $date',
                  style: TextStyle(fontSize: 12.sp, color: AppTheme.textHint),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.errorColor,
            ),
          ),
        ],
      ),
    );
  }
}
