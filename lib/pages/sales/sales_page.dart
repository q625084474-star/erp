import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_app/theme/app_theme.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('销售管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 新建销售订单
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textHint,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: '全部'),
            Tab(text: '待出库'),
            Tab(text: '已完成'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(),
          _buildOrderList(),
          _buildOrderList(),
        ],
      ),
      // 悬浮按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: 快速开单
        },
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('快速开单', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildOrderCard();
      },
    );
  }

  Widget _buildOrderCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 订单头部
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SO202605080001',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1890FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  '待出库',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF1890FF),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // 客户信息
          Row(
            children: [
              Icon(Icons.person_outline, size: 16.sp, color: AppTheme.textHint),
              SizedBox(width: 4.w),
              Text(
                '客户名称示例',
                style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // 商品信息
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 16.sp, color: AppTheme.textHint),
              SizedBox(width: 4.w),
              Text(
                '商品: 3种 | 数量: 50件',
                style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // 金额和时间
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '¥2,580.00',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.errorColor,
                ),
              ),
              Text(
                '2026-05-08 14:30',
                style: TextStyle(fontSize: 12.sp, color: AppTheme.textHint),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton('查看', AppTheme.textSecondary, () {}),
              SizedBox(width: 12.w),
              _buildActionButton('出库', AppTheme.primaryColor, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12.sp, color: color),
        ),
      ),
    );
  }
}
