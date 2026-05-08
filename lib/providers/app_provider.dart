import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // 是否为PDA设备
  bool _isPdaDevice = false;
  bool get isPdaDevice => _isPdaDevice;
  
  // 是否离线模式
  bool _isOffline = false;
  bool get isOffline => _isOffline;
  
  // 网络状态
  bool _isConnected = true;
  bool get isConnected => _isConnected;
  
  // 当前语言
  Locale _locale = const Locale('zh', 'CN');
  Locale get locale => _locale;
  
  // 主题模式
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  // 设置PDA模式
  void setPdaMode(bool isPda) {
    _isPdaDevice = isPda;
    notifyListeners();
  }

  // 设置离线模式
  void setOfflineMode(bool isOffline) {
    _isOffline = isOffline;
    notifyListeners();
  }

  // 设置网络状态
  void setNetworkStatus(bool isConnected) {
    _isConnected = isConnected;
    notifyListeners();
  }

  // 切换语言
  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // 切换主题
  void changeThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
