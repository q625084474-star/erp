import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:erp_app/theme/app_theme.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _scanResult = '';
  String _scanType = '入库'; // 入库、出库、盘点、查询
  bool _isScanning = false;

  final List<Map<String, dynamic>> _scanTypes = [
    {'type': '入库', 'icon': Icons.add_box_outlined, 'color': const Color(0xFF52C41A)},
    {'type': '出库', 'icon': Icons.outbox_outlined, 'color': const Color(0xFF1890FF)},
    {'type': '盘点', 'icon': Icons.fact_check_outlined, 'color': const Color(0xFFFAAD14)},
    {'type': '查询', 'icon': Icons.search, 'color': const Color(0xFF722ED1)},
  ];

  Future<void> _startScan() async {
    setState(() => _isScanning = true);
    
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#1F4E79',
        '取消',
        true,
        ScanMode.BARCODE,
      );
      
      if (barcodeScanRes != '-1') {
        setState(() => _scanResult = barcodeScanRes);
        _handleScanResult(barcodeScanRes);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '扫码失败: $e');
    } finally {
      setState(() => _isScanning = false);
    }
  }

  void _handleScanResult(String barcode) {
    // 根据扫码类型处理结果
    switch (_scanType) {
      case '入库':
        _showInboundDialog(barcode);
        break;
      case '出库':
        _showOutboundDialog(barcode);
        break;
      case '盘点':
        _showInventoryDialog(barcode);
        break;
      case '查询':
        _showQueryResult(barcode);
        break;
    }
  }

  void _showInboundDialog(String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('入库确认'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('条码: $barcode'),
            SizedBox(height: 12.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '入库数量',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: '入库成功');
            },
            child: Text('确认入库'),
          ),
        ],
      ),
    );
  }

  void _showOutboundDialog(String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('出库确认'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('条码: $barcode'),
            SizedBox(height: 12.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '出库数量',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: '出库成功');
            },
            child: Text('确认出库'),
          ),
        ],
      ),
    );
  }

  void _showInventoryDialog(String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('盘点录入'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('条码: $barcode'),
            Text('系统库存: 100'),
            SizedBox(height: 12.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '实际数量',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: '盘点录入成功');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  void _showQueryResult(String barcode) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '商品信息',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildInfoRow('条码', barcode),
            _buildInfoRow('商品名称', '示例商品'),
            _buildInfoRow('规格', '500ml'),
            _buildInfoRow('库存数量', '128'),
            _buildInfoRow('销售价', '¥25.00'),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: TextStyle(color: AppTheme.textHint, fontSize: 14.sp),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: Text('扫码$_scanType'),
      ),
      body: Column(
        children: [
          // 扫码类型选择
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _scanTypes.map((item) {
                final isSelected = _scanType == item['type'];
                return GestureDetector(
                  onTap: () {
                    setState(() => _scanType = item['type']);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? (item['color'] as Color).withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isSelected ? (item['color'] as Color) : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: isSelected ? (item['color'] as Color) : AppTheme.textHint,
                          size: 24.sp,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item['type'] as String,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isSelected ? (item['color'] as Color) : AppTheme.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // 扫码区域
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 120.sp,
                    color: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    '点击下方按钮开始扫码',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.textHint,
                    ),
                  ),
                  if (_scanResult.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '上次扫码: $_scanResult',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // 扫码按钮
          Container(
            padding: EdgeInsets.all(16.w),
            child: ElevatedButton.icon(
              onPressed: _isScanning ? null : _startScan,
              icon: _isScanning
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.qr_code_scanner),
              label: Text(_isScanning ? '扫描中...' : '开始扫码'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
