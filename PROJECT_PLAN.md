# TableTalk Flutter 项目实现计划

## 项目概述
基于HTML设计稿创建一个功能完整的Flutter餐厅应用，包含9个主要界面，支持用户登录、店铺浏览、评论查看、即时聊天等功能。

## 项目架构

### 1. 目录结构
```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── validators.dart
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── restaurant_model.dart
│   │   ├── staff_model.dart
│   │   ├── review_model.dart
│   │   └── chat_message_model.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── restaurant_repository.dart
│   │   └── chat_repository.dart
│   └── services/
│       ├── api_service.dart
│       └── local_storage_service.dart
├── presentation/
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── shops_screen.dart
│   │   ├── shop_detail_screen.dart
│   │   ├── shop_features_screen.dart
│   │   ├── reviews_screen.dart
│   │   ├── staff_list_screen.dart
│   │   ├── chat_verify_screen.dart
│   │   ├── chat_screen.dart
│   │   └── staff_detail_screen.dart
│   ├── widgets/
│   │   ├── app_bar_widget.dart
│   │   ├── card_widget.dart
│   │   ├── text_field_widget.dart
│   │   └── button_widget.dart
│   └── providers/
│       ├── auth_provider.dart
│       ├── restaurant_provider.dart
│       ├── chat_provider.dart
│       └── staff_provider.dart
└── routes/
    └── app_router.dart
```

### 2. 数据模型设计

#### User Model
```dart
class User {
  final String id;
  final String email;
  final String? phone;
  final String? displayName;
  final String? avatarUrl;
  
  User({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.avatarUrl,
  });
}
```

#### Restaurant Model
```dart
class Restaurant {
  final String id;
  final String name;
  final String type;
  final String distance;
  final String description;
  final String address;
  final String phone;
  final String hours;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  
  Restaurant({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.description,
    required this.address,
    required this.phone,
    required this.hours,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
  });
}
```

#### Staff Model
```dart
class Staff {
  final String id;
  final String name;
  final String position;
  final String status;
  final String experience;
  final double rating;
  final List<String> skills;
  final List<String> languages;
  
  Staff({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
    required this.experience,
    required this.rating,
    required this.skills,
    required this.languages,
  });
}
```

#### Review Model
```dart
class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final int rating;
  final String comment;
  final DateTime date;
  
  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
```

#### ChatMessage Model
```dart
class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isSentByUser;
  
  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isSentByUser,
  });
}
```

### 3. 路由配置

使用命名路由管理页面导航：
- `/login` - 登录界面
- `/shops` - 店铺列表
- `/shop-detail` - 店铺详情
- `/shop-features` - 店铺功能
- `/reviews` - 店铺评论
- `/staff-list` - 店员列表
- `/chat-verify` - 聊天验证
- `/chat` - 即时聊天
- `/staff-detail` - 店员详情

### 4. 状态管理方案

使用 `Provider` 进行状态管理：
- `AuthProvider`: 用户认证状态
- `RestaurantProvider`: 餐厅数据管理
- `ChatProvider`: 聊天状态管理
- `StaffProvider`: 店员信息管理

### 5. 网络接口预留

创建抽象类和接口，为后续网络集成预留空间：
- `AuthRepository`: 认证相关接口
- `RestaurantRepository`: 餐厅数据接口
- `ChatRepository`: 聊天功能接口

### 6. 可复用组件

创建以下可复用组件：
- `AppBarWidget`: 统一的顶部导航栏
- `CardWidget`: 卡片式布局组件
- `TextFieldWidget`: 统一的输入框
- `ButtonWidget`: 统一的按钮样式
- `AvatarWidget`: 头像组件

## 实现步骤

### 阶段1: 基础架构搭建
1. 创建项目目录结构
2. 设置主题配置
3. 创建数据模型
4. 设置路由配置

### 阶段2: 核心界面实现
1. 登录注册界面
2. 店铺列表界面
3. 店铺详情界面
4. 店铺功能界面

### 阶段3: 功能扩展
1. 店铺评论界面
2. 店员列表界面
3. 聊天验证界面
4. 即时聊天界面
5. 店员详情界面

### 阶段4: 优化和测试
1. 添加动画效果
2. 响应式布局优化
3. 性能优化
4. 测试用例编写

## 技术栈

- **Flutter**: 3.0+
- **Dart**: 2.17+
- **状态管理**: Provider
- **路由**: Navigator 2.0
- **网络**: Dio (预留)
- **本地存储**: SharedPreferences (预留)
- **UI**: Material Design 3

## 开发规范

1. 使用有意义的命名
2. 遵循Flutter官方代码规范
3. 每个文件不超过200行代码
4. 添加必要的注释
5. 使用const构造函数优化性能
6. 避免嵌套过深的Widget结构

## 后续扩展计划

1. 集成真实API
2. 添加用户认证
3. 实现实时聊天功能
4. 添加地图定位
5. 支持多语言
6. 添加推送通知
7. 实现离线缓存