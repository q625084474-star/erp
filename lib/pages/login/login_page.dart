import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_app/router/app_router.dart';
import 'package:erp_app/providers/user_provider.dart';
import 'package:erp_app/theme/app_theme.dart';
import 'package:erp_app/widgets/common_button.dart';
import 'package:erp_app/widgets/common_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 登录
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      _showMessage('请输入用户名');
      return;
    }
    if (password.isEmpty) {
      _showMessage('请输入密码');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: 调用登录API
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟登录成功
      await context.read<UserProvider>().login(
        token: 'mock_token_12345',
        user: {
          'id': 1,
          'userName': username,
          'name': username,
          'avatar': '',
          'deptId': 1,
          'storeId': 1,
        },
        perms: ['*'],
      );

      if (mounted) {
        AppRouter.pushAndRemoveUntil(context, AppRouter.main);
      }
    } catch (e) {
      _showMessage('登录失败：$e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              // Logo
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.inventory_2_rounded,
                    size: 48.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // 标题
              Center(
                child: Text(
                  '贸易零售ERP',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  '欢迎登录',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              // 用户名输入框
              CommonInput(
                controller: _usernameController,
                hintText: '请输入用户名',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 16.h),
              // 密码输入框
              CommonInput(
                controller: _passwordController,
                hintText: '请输入密码',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.textHint,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              SizedBox(height: 32.h),
              // 登录按钮
              CommonButton(
                text: '登 录',
                isLoading: _isLoading,
                onPressed: _login,
              ),
              SizedBox(height: 24.h),
              // 其他选项
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '忘记密码？',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '注册账号',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              // 底部信息
              Center(
                child: Column(
                  children: [
                    Text(
                      '登录即表示同意',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.textHint,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            '《用户协议》',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          '和',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppTheme.textHint,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            '《隐私政策》',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
