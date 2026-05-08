import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  // 用户信息
  Map<String, dynamic>? _userInfo;
  Map<String, dynamic>? get userInfo => _userInfo;
  
  // Token
  String? _token;
  String? get token => _token;
  
  // 是否已登录
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;
  
  // 用户权限列表
  List<String> _permissions = [];
  List<String> get permissions => _permissions;

  // 初始化 - 从本地存储加载用户信息
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final userInfoStr = prefs.getString('userInfo');
    if (userInfoStr != null) {
      _userInfo = json.decode(userInfoStr);
    }
    final permissionsStr = prefs.getString('permissions');
    if (permissionsStr != null) {
      _permissions = List<String>.from(json.decode(permissionsStr));
    }
    notifyListeners();
  }

  // 登录
  Future<void> login({
    required String token,
    required Map<String, dynamic> user,
    List<String>? perms,
  }) async {
    _token = token;
    _userInfo = user;
    _permissions = perms ?? [];
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userInfo', json.encode(user));
    await prefs.setString('permissions', json.encode(_permissions));
    
    notifyListeners();
  }

  // 退出登录
  Future<void> logout() async {
    _token = null;
    _userInfo = null;
    _permissions = [];
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userInfo');
    await prefs.remove('permissions');
    
    notifyListeners();
  }

  // 更新用户信息
  Future<void> updateUserInfo(Map<String, dynamic> user) async {
    _userInfo = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', json.encode(user));
    notifyListeners();
  }

  // 检查是否有某权限
  bool hasPermission(String permission) {
    return _permissions.contains(permission) || _permissions.contains('*');
  }

  // 获取用户名
  String get userName => _userInfo?['userName'] ?? _userInfo?['name'] ?? '未登录';
  
  // 获取用户头像
  String get avatar => _userInfo?['avatar'] ?? '';
  
  // 获取用户ID
  int? get userId => _userInfo?['id'];
  
  // 获取部门ID
  int? get deptId => _userInfo?['deptId'];
  
  // 获取门店ID
  int? get storeId => _userInfo?['storeId'];
}
