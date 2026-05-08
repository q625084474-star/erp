import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_app/theme/app_theme.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('库存管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 筛选
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          Container(
            padding: EdgeInsets.all(16.w),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppTheme.bgColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 20.sp, color: AppTheme.textHint),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: '搜索商品名称/条码',
                              hintStyle: TextStyle(fontSize: 14.sp, color: AppTheme.textHint),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // 扫码按钮
                GestureDetector(
                  onTap: () {
                    // TODO: 打开扫码
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 22.sp),
                  ),
                ),
              ],
            ),
          ),
          
          // 功能菜单
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMenuButton(Icons.add_box_outlined, '入库', const Color(0xFF52C41A)),
                _buildMenuButton(Icons.outbox_outlined, '出库', const Color(0xFF1890FF)),
                _buildMenuButton(Icons.fact_check_outlined, '盘点', const Color(0xFFFAAD14)),
                _buildMenuButton(Icons.swap_horiz, '调拨', const Color(0xFF722ED1)),
              ],
            ),
          ),
          
          // 库存列表
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildInventoryItem();
                },
              ),
            ),
          ),
        ],
      ),
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
            style: TextStyle(
              fontSize: 12.sp,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          // 商品图片
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppTheme.bgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.inventory_2, size: 30.sp, color: AppTheme.textHint),
          ),
          SizedBox(width: 12.w),
          // 商品信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '商品名称示例',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '规格: 500ml | 条码: 6901234567890',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textHint,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      '库存: ',
                      style: TextStyle(fontSize: 12.sp, color: AppTheme.textSecondary),
                    ),
                    Text(
                      '128',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 操作按钮
          Icon(Icons.chevron_right, size: 20.sp, color: AppTheme.textHint),
        ],
      ),
    );
  }
}
