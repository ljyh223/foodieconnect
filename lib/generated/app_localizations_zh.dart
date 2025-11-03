// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'TableTalk';

  @override
  String get foodieConnect => 'Foodie Connect';

  @override
  String get tableTalk => 'TableTalk';

  @override
  String get discoverFoodShareExperience => '发现美食，分享体验';

  @override
  String get login => '登录';

  @override
  String get register => '注册';

  @override
  String get email => '邮箱地址';

  @override
  String get password => '密码';

  @override
  String get displayName => '显示名称';

  @override
  String get phoneNumber => '手机号码';

  @override
  String get pleaseEnterEmail => '请输入邮箱地址';

  @override
  String get pleaseEnterValidEmail => '请输入有效的邮箱地址';

  @override
  String get pleaseEnterPassword => '请输入密码';

  @override
  String get passwordMinLength => '密码至少需要6位字符';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get noAccountYet => '还没有账号？';

  @override
  String get registerNow => '立即注册';

  @override
  String get alreadyHaveAccount => '已有账号？';

  @override
  String get loginNow => '立即登录';

  @override
  String get createAccount => '创建账号';

  @override
  String get joinTableTalk => '加入TableTalk，发现更多美食';

  @override
  String get loginFailed => '登录失败，请稍后重试';

  @override
  String get checkingLoginStatus => '正在检查登录状态...';

  @override
  String get authCheckFailed => '认证检查失败';

  @override
  String get authCheckTimeout => '认证检查超时';

  @override
  String get search => '搜索';

  @override
  String get noRestaurants => '暂无餐厅信息';

  @override
  String get loadingFailed => '加载失败';

  @override
  String get retry => '重试';

  @override
  String get open => '营业中';

  @override
  String get closed => '已打烊';

  @override
  String get basicInfo => '基础信息';

  @override
  String get address => '地址';

  @override
  String distanceFromYou(String distance) {
    return '距离您$distance';
  }

  @override
  String get businessHours => '营业时间';

  @override
  String get phone => '电话';

  @override
  String get rating => '评分';

  @override
  String totalReviews(int count) {
    return '共$count条评价';
  }

  @override
  String get dishReviews => '菜肴点评';

  @override
  String get noReviews => '暂无评价';

  @override
  String get chatRoom => '聊天室';

  @override
  String get chatWithStaff => '与店员实时沟通，了解更多详情';

  @override
  String get enterChatRoom => '进入聊天室';

  @override
  String get staffReviews => '店员评价';

  @override
  String get noStaffInfo => '暂无店员信息';

  @override
  String get viewAllStaff => '查看所有店员';

  @override
  String get experience => '经验';

  @override
  String get restaurantImages => '餐厅图片';

  @override
  String get averagePrice => '人均消费';

  @override
  String get recommendedDishes => '推荐菜品';

  @override
  String get loading => '加载中...';

  @override
  String get menu => '菜单';

  @override
  String get viewFullMenu => '查看完整菜单';

  @override
  String get viewMenu => '查看菜单';

  @override
  String get menuFeatureInDevelopment => '菜单功能开发中';

  @override
  String get getMenuFailed => '获取菜单失败';

  @override
  String get getShopInfoFailed => '获取店铺信息失败';

  @override
  String get userComments => '用户评论';

  @override
  String get publishReview => '发布评价';

  @override
  String get ratingScore => '评分';

  @override
  String get reviewContent => '评价内容';

  @override
  String get shareDiningExperience => '分享你的用餐体验...';

  @override
  String get addImages => '添加图片';

  @override
  String get takePhoto => '拍照';

  @override
  String get selectFromGallery => '相册';

  @override
  String get selectFromAlbum => '从相册选择';

  @override
  String get addImage => '添加图片';

  @override
  String get publish => '发布';

  @override
  String get restaurantInfoInvalid => '餐厅信息无效';

  @override
  String get pleaseEnterReviewContent => '请输入评价内容';

  @override
  String get reviewPublished => '评价已发布';

  @override
  String get publishFailed => '发布失败';

  @override
  String get takePhotoFailed => '拍照失败';

  @override
  String get selectImageFailed => '选择图片失败';

  @override
  String get staffList => '店员列表';

  @override
  String get getStaffListFailed => '获取店员列表失败';

  @override
  String get noStaff => '暂无店员信息';

  @override
  String get staffDetails => '店员详情';

  @override
  String get staffInfoNotExists => '店员信息不存在';

  @override
  String get getStaffDetailsFailed => '获取店员详情失败';

  @override
  String get loadStaffReviewsFailed => '加载店员评价失败';

  @override
  String get userReviews => '用户评价';

  @override
  String reviewCount(int count) {
    return '$count条评价';
  }

  @override
  String get shopFeatures => '店铺功能';

  @override
  String get viewComments => '查看评论';

  @override
  String get viewUserReviews => '查看用户评价';

  @override
  String get instantChat => '即时聊天';

  @override
  String get chatWithStaffRealtime => '与店员实时交流';

  @override
  String get viewStaff => '查看店员';

  @override
  String get onlineStaffList => '在线店员列表';

  @override
  String get viewMenuDishes => '查看菜单';

  @override
  String get browseAllDishes => '浏览所有菜品';

  @override
  String get chat => '聊天';

  @override
  String get restaurantChatVerification => '餐厅聊天验证';

  @override
  String get enterRestaurantIdAndCode => '请输入餐厅ID和验证码以加入聊天室';

  @override
  String get verificationCode => '验证码';

  @override
  String get pleaseEnterVerificationCode => '请填写验证码';

  @override
  String get verificationFailed => '验证失败，请检查餐厅ID和验证码';

  @override
  String verificationError(String error) {
    return '验证失败：$error';
  }

  @override
  String get verifyAndStartChat => '验证并开始聊天';

  @override
  String get pleaseVerifyFirst => '请先通过验证界面加入聊天室';

  @override
  String get staffChatFeatureMoved => '店员聊天功能已迁移至餐厅聊天室';

  @override
  String get restaurantChatRoom => '餐厅聊天室';

  @override
  String get initializeChatRoomFailed => '初始化聊天室失败';

  @override
  String initializeChatRoomError(String error) {
    return '初始化聊天室失败: $error';
  }

  @override
  String get noAvailableChatRoom => '当前无可用聊天室';

  @override
  String get noMessagesStartChat => '暂无消息，开始聊天吧！';

  @override
  String get websocketNotConnected => 'WebSocket未连接';

  @override
  String get connected => '已连接';

  @override
  String get disconnected => '未连接';

  @override
  String get enterMessage => '输入消息...';

  @override
  String get newMessages => '新消息';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get close => '关闭';

  @override
  String get settings => '设置';

  @override
  String get languageSettings => '语言设置';

  @override
  String get currentLanguage => '当前语言';

  @override
  String get accountSettings => '账户设置';

  @override
  String get profile => '个人资料';

  @override
  String get privacy => '隐私设置';

  @override
  String get notifications => '通知设置';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get logout => '退出登录';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'TableTalk';

  @override
  String get foodieConnect => 'Foodie Connect';

  @override
  String get tableTalk => 'TableTalk';

  @override
  String get discoverFoodShareExperience => '發現美食，分享體驗';

  @override
  String get login => '登入';

  @override
  String get register => '註冊';

  @override
  String get email => '郵箱地址';

  @override
  String get password => '密碼';

  @override
  String get displayName => '顯示名稱';

  @override
  String get phoneNumber => '手機號碼';

  @override
  String get pleaseEnterEmail => '請輸入郵箱地址';

  @override
  String get pleaseEnterValidEmail => '請輸入有效的郵箱地址';

  @override
  String get pleaseEnterPassword => '請輸入密碼';

  @override
  String get passwordMinLength => '密碼至少需要6位字符';

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get noAccountYet => '還沒有帳號？';

  @override
  String get registerNow => '立即註冊';

  @override
  String get alreadyHaveAccount => '已有帳號？';

  @override
  String get loginNow => '立即登入';

  @override
  String get createAccount => '創建帳號';

  @override
  String get joinTableTalk => '加入TableTalk，發現更多美食';

  @override
  String get loginFailed => '登入失敗，請稍後重試';

  @override
  String get checkingLoginStatus => '正在檢查登入狀態...';

  @override
  String get authCheckFailed => '認證檢查失敗';

  @override
  String get authCheckTimeout => '認證檢查超時';

  @override
  String get search => '搜尋';

  @override
  String get noRestaurants => '暫無餐廳信息';

  @override
  String get loadingFailed => '載入失敗';

  @override
  String get retry => '重試';

  @override
  String get open => '營業中';

  @override
  String get closed => '已打烊';

  @override
  String get basicInfo => '基礎信息';

  @override
  String get address => '地址';

  @override
  String distanceFromYou(String distance) {
    return '距離您$distance';
  }

  @override
  String get businessHours => '營業時間';

  @override
  String get phone => '電話';

  @override
  String get rating => '評分';

  @override
  String totalReviews(int count) {
    return '共$count條評價';
  }

  @override
  String get dishReviews => '菜肴點評';

  @override
  String get noReviews => '暫無評價';

  @override
  String get chatRoom => '聊天室';

  @override
  String get chatWithStaff => '與店員即時溝通，了解更多詳情';

  @override
  String get enterChatRoom => '進入聊天室';

  @override
  String get staffReviews => '店員評價';

  @override
  String get noStaffInfo => '暫無店員信息';

  @override
  String get viewAllStaff => '查看所有店員';

  @override
  String get experience => '經驗';

  @override
  String get restaurantImages => '餐廳圖片';

  @override
  String get averagePrice => '人均消費';

  @override
  String get recommendedDishes => '推薦菜品';

  @override
  String get loading => '載入中...';

  @override
  String get menu => '菜單';

  @override
  String get viewFullMenu => '查看完整菜單';

  @override
  String get viewMenu => '查看菜單';

  @override
  String get menuFeatureInDevelopment => '菜單功能開發中';

  @override
  String get getMenuFailed => '獲取菜單失敗';

  @override
  String get getShopInfoFailed => '獲取店鋪信息失敗';

  @override
  String get userComments => '用戶評論';

  @override
  String get publishReview => '發布評價';

  @override
  String get ratingScore => '評分';

  @override
  String get reviewContent => '評價內容';

  @override
  String get shareDiningExperience => '分享你的用餐體驗...';

  @override
  String get addImages => '添加圖片';

  @override
  String get takePhoto => '拍照';

  @override
  String get selectFromGallery => '相冊';

  @override
  String get selectFromAlbum => '從相冊選擇';

  @override
  String get addImage => '添加圖片';

  @override
  String get publish => '發布';

  @override
  String get restaurantInfoInvalid => '餐廳信息無效';

  @override
  String get pleaseEnterReviewContent => '請輸入評價內容';

  @override
  String get reviewPublished => '評價已發布';

  @override
  String get publishFailed => '發布失敗';

  @override
  String get takePhotoFailed => '拍照失敗';

  @override
  String get selectImageFailed => '選擇圖片失敗';

  @override
  String get staffList => '店員列表';

  @override
  String get getStaffListFailed => '獲取店員列表失敗';

  @override
  String get noStaff => '暫無店員信息';

  @override
  String get staffDetails => '店員詳情';

  @override
  String get staffInfoNotExists => '店員信息不存在';

  @override
  String get getStaffDetailsFailed => '獲取店員詳情失敗';

  @override
  String get loadStaffReviewsFailed => '載入店員評價失敗';

  @override
  String get userReviews => '用戶評價';

  @override
  String reviewCount(int count) {
    return '$count條評價';
  }

  @override
  String get shopFeatures => '店鋪功能';

  @override
  String get viewComments => '查看評論';

  @override
  String get viewUserReviews => '查看用戶評價';

  @override
  String get instantChat => '即時聊天';

  @override
  String get chatWithStaffRealtime => '與店員即時交流';

  @override
  String get viewStaff => '查看店員';

  @override
  String get onlineStaffList => '在線店員列表';

  @override
  String get viewMenuDishes => '查看菜單';

  @override
  String get browseAllDishes => '瀏覽所有菜品';

  @override
  String get chat => '聊天';

  @override
  String get restaurantChatVerification => '餐廳聊天驗證';

  @override
  String get enterRestaurantIdAndCode => '請輸入餐廳ID和驗證碼以加入聊天室';

  @override
  String get verificationCode => '驗證碼';

  @override
  String get pleaseEnterVerificationCode => '請填寫驗證碼';

  @override
  String get verificationFailed => '驗證失敗，請檢查餐廳ID和驗證碼';

  @override
  String verificationError(String error) {
    return '驗證失敗：$error';
  }

  @override
  String get verifyAndStartChat => '驗證並開始聊天';

  @override
  String get pleaseVerifyFirst => '請先通過驗證界面加入聊天室';

  @override
  String get staffChatFeatureMoved => '店員聊天功能已遷移至餐廳聊天室';

  @override
  String get restaurantChatRoom => '餐廳聊天室';

  @override
  String get initializeChatRoomFailed => '初始化聊天室失敗';

  @override
  String initializeChatRoomError(String error) {
    return '初始化聊天室失敗: $error';
  }

  @override
  String get noAvailableChatRoom => '當前無可用聊天室';

  @override
  String get noMessagesStartChat => '暫無消息，開始聊天吧！';

  @override
  String get websocketNotConnected => 'WebSocket未連接';

  @override
  String get connected => '已連接';

  @override
  String get disconnected => '未連接';

  @override
  String get enterMessage => '輸入消息...';

  @override
  String get newMessages => '新消息';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get close => '關閉';

  @override
  String get settings => '設定';

  @override
  String get languageSettings => '語言設定';

  @override
  String get currentLanguage => '當前語言';

  @override
  String get accountSettings => '帳戶設定';

  @override
  String get profile => '個人資料';

  @override
  String get privacy => '隱私設定';

  @override
  String get notifications => '通知設定';

  @override
  String get about => '關於';

  @override
  String get version => '版本';

  @override
  String get logout => '登出';
}
