class AppConfig {
  // 应用名称
  static const String appName = '贸易零售ERP';
  
  // 应用版本
  static const String version = '1.0.0';
  
  // 是否调试模式
  static const bool isDebug = true;
  
  // API基础地址 - 开发环境
  static const String baseUrl = 'http://192.168.1.100:8080/api';
  
  // API基础地址 - 生产环境
  static const String baseUrlProd = 'https://api.example.com/api';
  
  // 超时时间（秒）
  static const int timeout = 15;
  
  // 本地数据库名称
  static const String dbName = 'erp_app.db';
  
  // 本地数据库版本
  static const int dbVersion = 1;
  
  // 分页配置
  static const int pageSize = 20;
  
  // 缓存过期时间（分钟）
  static const int cacheExpire = 30;
  
  // 是否启用离线模式
  static const bool enableOffline = true;
  
  // 是否启用PDA模式
  static const bool enablePda = true;
}
