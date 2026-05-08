# 贸易零售ERP - 安卓APP

基于Flutter开发的贸易零售ERP移动端应用，支持普通安卓手机和PDA手持终端设备。

## 功能模块

- **首页** - 工作台、待办事项、数据概览
- **库存管理** - 入库、出库、盘点、调拨、库存查询
- **销售管理** - 销售订单、销售出库、销售退货
- **采购管理** - 采购申请、采购订单、采购入库
- **财务管理** - 应收应付、费用管理、财务报表
- **扫码功能** - PDA扫码入库/出库/盘点/查询

## 技术栈

- **Flutter** 3.x - 跨平台UI框架
- **Provider** - 状态管理
- **Dio** - 网络请求
- **ScreenUtil** - 屏幕适配
- **SQLite** - 本地数据库（离线模式）
- **flutter_barcode_scanner** - 条码扫描

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── config/
│   └── app_config.dart       # 应用配置
├── theme/
│   └── app_theme.dart        # 主题配置
├── router/
│   └── app_router.dart       # 路由管理
├── providers/
│   ├── app_provider.dart     # 应用状态
│   └── user_provider.dart    # 用户状态
├── utils/
│   └── http_util.dart        # 网络请求工具
├── pages/
│   ├── splash/               # 启动页
│   ├── login/                # 登录页
│   ├── main/                 # 主页面
│   ├── home/                 # 首页
│   ├── inventory/            # 库存管理
│   ├── sales/                # 销售管理
│   ├── purchase/             # 采购管理
│   ├── finance/              # 财务管理
│   ├── mine/                 # 我的
│   └── scan/                 # 扫码页面
└── widgets/
    ├── common_button.dart    # 通用按钮
    ├── common_input.dart     # 通用输入框
    └── menu_item.dart        # 菜单项组件
```

## 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- Android SDK (API 21+)

## 安装与运行

### 1. 安装Flutter SDK

请参考Flutter官方文档安装Flutter SDK：
- [Windows安装指南](https://docs.flutter.dev/get-started/install/windows)
- [中国镜像配置](https://flutter.cn/community/china)

### 2. 配置环境变量

```bash
# Windows PowerShell
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

### 3. 安装依赖

```bash
cd erp_app
flutter pub get
```

### 4. 运行项目

```bash
# 检查环境
flutter doctor

# 连接设备或启动模拟器
flutter devices

# 运行应用
flutter run

# 构建APK
flutter build apk --release
```

## PDA适配说明

本应用已针对PDA设备进行以下适配：

1. **扫码功能** - 调用PDA内置扫码模块，支持一维码、二维码
2. **屏幕适配** - 支持多种分辨率，优化小屏幕显示
3. **物理按键** - 适配PDA扫码键、功能键
4. **离线模式** - 本地SQLite存储，联网自动同步
5. **大按钮设计** - 方便戴手套操作

## API配置

修改 `lib/config/app_config.dart` 配置后端API地址：

```dart
// 开发环境
static const String baseUrl = 'http://192.168.1.100:8080/api';

// 生产环境
static const String baseUrlProd = 'https://api.example.com/api';
```

## 后续开发计划

- [ ] 对接后端API
- [ ] 完善离线模式
- [ ] 添加消息推送
- [ ] 优化PDA扫码性能
- [ ] 添加打印功能

## 相关文档

- [ERP系统设计方案](../贸易零售ERP系统设计方案.docx)

## License

MIT License
