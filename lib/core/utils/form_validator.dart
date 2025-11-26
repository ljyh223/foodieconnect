/// 表单验证工具类
/// 提供常用的表单验证方法
class FormValidator {
  /// 验证邮箱格式
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '邮箱不能为空';
    }
    
    // 使用正则表达式验证邮箱格式
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    
    return null;
  }

  /// 验证非空字符串
  static String? validateNotEmpty(String? value, {String fieldName = '此字段'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName不能为空';
    }
    return null;
  }

  /// 验证用户名
  static String? validateDisplayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '用户名不能为空';
    }
    
    if (value.trim().length < 2) {
      return '用户名至少需要2个字符';
    }
    
    if (value.trim().length > 50) {
      return '用户名不能超过50个字符';
    }
    
    return null;
  }

  /// 验证个人简介
  static String? validateBio(String? value) {
    if (value != null && value.trim().length > 500) {
      return '个人简介不能超过500个字符';
    }
    return null;
  }

  /// 验证手机号码
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // 手机号可以为空
    }
    
    // 简单的手机号验证（可根据需要调整）
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return '请输入有效的手机号码';
    }
    
    return null;
  }

  /// 验证密码
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '密码不能为空';
    }
    
    if (value.length < 6) {
      return '密码至少需要6个字符';
    }
    
    if (value.length > 20) {
      return '密码不能超过20个字符';
    }
    
    return null;
  }

  /// 验证确认密码
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return '请确认密码';
    }
    
    if (value != password) {
      return '两次输入的密码不一致';
    }
    
    return null;
  }
}