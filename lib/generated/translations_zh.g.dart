///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsZh with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppZh app = _TranslationsAppZh._(_root);
	@override late final _TranslationsAuthZh auth = _TranslationsAuthZh._(_root);
	@override late final _TranslationsChatZh chat = _TranslationsChatZh._(_root);
	@override late final _TranslationsProfileZh profile = _TranslationsProfileZh._(_root);
	@override late final _TranslationsRestaurantZh restaurant = _TranslationsRestaurantZh._(_root);
	@override late final _TranslationsReviewZh review = _TranslationsReviewZh._(_root);
	@override late final _TranslationsSettingZh setting = _TranslationsSettingZh._(_root);
	@override late final _TranslationsStaffZh staff = _TranslationsStaffZh._(_root);
}

// Path: app
class _TranslationsAppZh implements TranslationsAppEn {
	_TranslationsAppZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 应用标题
	@override String get appTitle => 'FoodieConnect';

	/// 应用中文名称
	@override String get foodieConnect => 'FoodieConnect';

	/// 应用副标题
	@override String get discoverFoodShareExperience => '发现美食，分享体验';

	/// 搜索框提示文本
	@override String get search => '搜索';

	/// 首页标签文本
	@override String get home => '首页';

	/// 加载中提示
	@override String get loading => '加载中...';

	/// 加载失败提示
	@override String get loadingFailed => '加载失败';

	/// 重试按钮文本
	@override String get retry => '重试';

	/// 营业状态
	@override String get open => '营业中';

	/// 打烊状态
	@override String get closed => '已打烊';

	/// 个人主页标题
	@override String get userProfile => '个人主页';

	/// 其他用户主页标题
	@override String get otherUserProfile => '用户主页';

	/// 关注列表标题
	@override String get followingList => '关注列表';

	/// 我的关注标题
	@override String get myFollowing => '我的关注';

	/// 连接按钮文本
	@override String get connect => 'Connect';

	/// 关注按钮文本
	@override String get follow => '关注';

	/// 已关注状态文本
	@override String get following => '已关注';

	/// 以只读模式进入聊天室按钮文本
	@override String get enterReadOnlyMode => '以只读模式进入';

	/// 只读模式提示信息
	@override String get readOnlyModeNotice => '您当前处于只读模式，只能查看消息，无法发送消息';

	/// 只读模式底部提示
	@override String get readOnlyModeTip => '只读模式：您可以查看消息，但无法发送';

	/// 取消关注按钮文本
	@override String get unfollow => '取消关注';

	/// 取消关注确认对话框
	@override String unfollowConfirm({required Object username}) => '确定要取消关注 ${username} 吗？';

	/// 喜好食物标题
	@override String get foodPreferences => '喜好食物';

	/// 无喜好食物信息提示
	@override String get noFoodPreferences => '暂无喜好食物信息';

	/// 个人简介标题
	@override String get personalBio => '个人简介';

	/// 无个人简介提示
	@override String get noBio => '这个人很懒，什么都没有留下...';

	/// 推荐餐厅标题
	@override String get recommendedRestaurants => '推荐餐厅';

	/// 无推荐餐厅提示
	@override String get noRecommendedRestaurants => '暂无推荐餐厅';

	/// 无关注提示
	@override String get noFollowing => '暂无关注';

	/// 发现用户提示
	@override String get discoverUsers => '去发现感兴趣的用户吧';

	/// 保存按钮文本
	@override String get save => '保存';

	/// 编辑按钮文本
	@override String get edit => '编辑';

	/// 保存成功提示
	@override String get saveSuccess => '保存成功';

	/// 保存失败提示
	@override String get saveFailed => '保存失败';

	/// 关注成功提示
	@override String get followSuccess => '关注成功';

	/// 关注失败提示
	@override String get followFailed => '关注失败';

	/// 取消关注成功提示
	@override String get unfollowSuccess => '已取消关注';

	/// 取消关注失败提示
	@override String get unfollowFailed => '取消关注失败';

	/// 用户不存在提示
	@override String get userNotFound => '用户不存在';

	/// 未知用户文本
	@override String get unknownUser => '未知用户';

	/// 个人简介输入提示
	@override String get introduceYourself => '介绍一下自己...';

	/// 取消按钮文本
	@override String get cancel => '取消';

	/// 推荐功能标题
	@override String get recommendations => '推荐';

	/// 推荐用户标题
	@override String get recommendedUsers => '推荐关注';

	/// 查看更多按钮
	@override String get viewMore => '查看更多';

	/// 无推荐用户提示
	@override String get noRecommendations => '暂无推荐用户';

	/// 搜索推荐用户提示
	@override String get searchingRecommendations => '系统正在为您寻找可能感兴趣的用户';

	/// 感兴趣状态
	@override String get interested => '感兴趣';

	/// 不感兴趣状态
	@override String get notInterested => '不感兴趣';

	/// 标记感兴趣成功提示
	@override String get markAsInterested => '已标记为感兴趣';

	/// 标记不感兴趣成功提示
	@override String get markAsNotInterested => '已标记为不感兴趣';

	/// 推荐分数标签
	@override String get recommendationScore => '推荐分数';

	/// 推荐理由标签
	@override String get recommendationReason => '推荐理由';

	/// 协同过滤推荐理由
	@override String get collaborativeRecommendation => '基于共同喜好推荐';

	/// 社交推荐理由
	@override String get socialRecommendation => '您关注的人也关注了TA';

	/// 混合推荐理由
	@override String get hybridRecommendation => '综合推荐';

	/// 共同兴趣描述
	@override String commonInterests({required String interests}) => '共同喜欢${interests}';

	/// 共同访问餐厅描述
	@override String commonVisits({required int count}) => '共同访问过${count}家餐厅';

	/// 筛选按钮
	@override String get filter => '筛选';

	/// 排序按钮
	@override String get sort => '排序';

	/// 筛选对话框标题
	@override String get filterByStatus => '筛选推荐';

	/// 排序对话框标题
	@override String get sortBy => '排序方式';

	/// 全部选项
	@override String get all => '全部';

	/// 未查看状态
	@override String get unviewed => '未查看';

	/// 已查看状态
	@override String get viewed => '已查看';

	/// 按分数排序
	@override String get sortByScore => '推荐分数';

	/// 按时间排序
	@override String get sortByTime => '创建时间';

	/// 按查看时间排序
	@override String get sortByViewTime => '查看时间';

	/// 清除推荐按钮
	@override String get clearAllRecommendations => '清除所有推荐';

	/// 清除推荐确认对话框内容
	@override String get clearAllConfirm => '确定要清除所有推荐吗？此操作不可撤销。';

	/// 推荐总数统计
	@override String totalRecommendations({required int count}) => '共 ${count} 个推荐';

	/// 无更多推荐提示
	@override String get noMoreRecommendations => '没有更多推荐了';

	/// 查看推荐详情提示
	@override String get recommendationDetail => '查看推荐详情';

	/// 操作失败提示
	@override String operationFailed({required String error}) => '操作失败: ${error}';

	/// 发现页面标题
	@override String get discover => '发现';

	/// 返回按钮文本
	@override String get back => '返回';

	/// 设置按钮文本
	@override String get settings => '设置';

	/// 编辑资料按钮文本
	@override String get editProfile => '编辑资料';

	/// 清除所有推荐按钮文本
	@override String get clearAll => '清除所有推荐';

	/// 确定按钮文本
	@override String get confirm => '确定';

	/// 共同餐厅标签
	@override String get commonRestaurants => '共同餐厅';

	/// 相似度标签
	@override String get similarity => '相似度';
}

// Path: auth
class _TranslationsAuthZh implements TranslationsAuthEn {
	_TranslationsAuthZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 登录按钮文本
	@override String get login => '登录';

	/// 注册按钮文本
	@override String get register => '注册';

	/// 邮箱输入框标签
	@override String get email => '邮箱地址';

	/// 密码输入框标签
	@override String get password => '密码';

	/// 显示名称输入框标签
	@override String get displayName => '显示名称';

	/// 手机号码输入框标签
	@override String get phoneNumber => '手机号码';

	/// 邮箱验证错误信息
	@override String get pleaseEnterEmail => '请输入邮箱地址';

	/// 邮箱格式验证错误信息
	@override String get pleaseEnterValidEmail => '请输入有效的邮箱地址';

	/// 密码验证错误信息
	@override String get pleaseEnterPassword => '请输入密码';

	/// 密码长度验证错误信息
	@override String get passwordMinLength => '密码至少需要6位字符';

	/// 忘记密码链接文本
	@override String get forgotPassword => '忘记密码？';

	/// 没有账号提示文本
	@override String get noAccountYet => '还没有账号？';

	/// 立即注册链接文本
	@override String get registerNow => '立即注册';

	/// 已有账号提示文本
	@override String get alreadyHaveAccount => '已有账号？';

	/// 立即登录链接文本
	@override String get loginNow => '立即登录';

	/// 创建账号标题
	@override String get createAccount => '创建账号';

	/// 注册页面副标题
	@override String get joinFoodieConnect => '加入FoodieConnect，发现更多美食';

	/// 登录失败提示
	@override String get loginFailed => '登录失败，请稍后重试';

	/// 检查登录状态提示
	@override String get checkingLoginStatus => '正在检查登录状态...';

	/// 认证检查失败提示
	@override String get authCheckFailed => '认证检查失败';

	/// 认证检查超时提示
	@override String get authCheckTimeout => '认证检查超时';

	/// Error message shown to user
	@override String get invalidEmailOrPassword => '邮箱或密码错误';

	/// Prefix when registration throws
	@override String get registrationFailed => '注册失败';

	/// Error message shown to user
	@override String get logoutFailed => '登出失败';

	/// Error message shown to user
	@override String get restoreLoginFailed => '恢复登录状态失败';

	/// 登录成功提示
	@override String get loginSuccessful => '登录成功';

	/// 注册成功提示
	@override String get registrationSuccessful => '注册成功';
}

// Path: chat
class _TranslationsChatZh implements TranslationsChatEn {
	_TranslationsChatZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 聊天室标题
	@override String get chatRoom => '聊天室';

	/// 聊天室描述
	@override String get chatWithStaff => '与店员实时沟通，了解更多详情';

	/// 进入聊天室按钮
	@override String get enterChatRoom => '进入聊天室';

	/// 餐厅聊天验证标题
	@override String get restaurantChatVerification => '餐厅聊天验证';

	/// 输入餐厅ID和验证码提示
	@override String get enterRestaurantIdAndCode => '请输入餐厅ID和验证码以加入聊天室';

	/// 验证码标签
	@override String get verificationCode => '验证码';

	/// 请填写验证码提示
	@override String get pleaseEnterVerificationCode => '请填写验证码';

	/// 验证失败提示
	@override String get verificationFailed => '验证失败，请检查餐厅ID和验证码';

	/// 验证错误提示
	@override String verificationError({required String error}) => '验证失败：${error}';

	/// 获取聊天室信息失败提示
	@override String get failedToGetChatRoomInfo => '获取聊天室信息失败';

	/// 进入只读模式失败提示
	@override String get enterReadOnlyModeError => '进入只读模式失败：';

	/// 验证并开始聊天按钮
	@override String get verifyAndStartChat => '验证并开始聊天';

	/// 请先验证提示
	@override String get pleaseVerifyFirst => '请先通过验证界面加入聊天室';

	/// 店员聊天功能迁移提示
	@override String get staffChatFeatureMoved => '店员聊天功能已迁移至餐厅聊天室';

	/// 餐厅聊天室名称
	@override String get restaurantChatRoom => '餐厅聊天室';

	/// 初始化聊天室失败提示
	@override String get initializeChatRoomFailed => '初始化聊天室失败';

	/// 初始化聊天室错误提示
	@override String initializeChatRoomError({required String error}) => '初始化聊天室失败: ${error}';

	/// 无可用聊天室提示
	@override String get noAvailableChatRoom => '当前无可用聊天室';

	/// 无消息提示
	@override String get noMessagesStartChat => '暂无消息，开始聊天吧！';

	/// WebSocket未连接提示
	@override String get websocketNotConnected => 'WebSocket未连接';

	/// 已连接状态
	@override String get connected => '已连接';

	/// 未连接状态
	@override String get disconnected => '未连接';

	/// 输入消息提示
	@override String get enterMessage => '输入消息...';

	/// 新消息提示
	@override String get newMessages => '新消息';

	/// 聊天标题
	@override String get chat => '聊天';

	/// Label for today in chat time separator
	@override String get today => '今天';

	/// Label for yesterday in chat time separator
	@override String get yesterday => '昨天';

	/// Date format when message is from this year
	@override String dateFormatThisYear({required int month, required int day}) => '${month}月${day}日';

	/// Date format when message is from another year
	@override String dateFormatOtherYear({required int year, required int month, required int day}) => '${year}年${month}月${day}日';

	/// Time format used after today/yesterday labels
	@override String timeFormat({required String hour, required String minute}) => '${hour}:${minute}';

	/// Error hint when STOMP connection fails
	@override String stompConnectionError({required String error}) => 'STOMP连接错误：${error}';

	/// Toast when initial connect throws
	@override String stompConnectFail({required String error}) => 'STOMP WebSocket连接失败：${error}';

	/// Hint when waiting for connection timeout
	@override String get websocketTimeout => 'WebSocket连接超时，请检查网络连接';

	/// Hint when back-end does not return roomId/tempToken
	@override String get verifyFailNoRoomOrToken => '验证失败：未获取到聊天室ID或临时令牌';

	/// Toast when verifyChatRoom API throws
	@override String verifyRoomFail({required String error}) => '验证聊天室失败：${error}';

	/// Toast when STOMP joinRoom throws
	@override String joinRoomFail({required String error}) => '加入聊天室失败：${error}';

	/// Toast when fetchMessages API throws
	@override String loadMessageFail({required String error}) => '获取消息失败：${error}';

	/// Toast when sendMessage but socket disconnected
	@override String get notConnectedCantSend => 'STOMP WebSocket未连接，无法发送消息';

	/// Toast when sendMessage API throws
	@override String sendMessageFail({required String error}) => '发送消息失败：${error}';

	/// Toast when leaveRoom API throws
	@override String leaveRoomFail({required String error}) => '离开聊天室失败：${error}';

	/// Toast when subscribeToNotifications throws
	@override String subscribeNotificationFail({required String error}) => '订阅通知失败：${error}';

	/// Thrown when send/join is called before connected
	@override String get stompNotConnected => '未连接，请等待 WebSocket 完成连接';

	/// WebSocket连接中提示
	@override String get websocketConnecting => '正在连接WebSocket...';

	/// Connection exception text pushed to connectionStateController
	@override String stompConnectFailed({required String error}) => 'WebSocket 连接失败：${error}';

	@override String get stompConnected => '已连接';
	@override String get stompDisconnected => '连接已断开';
	@override String get msgParseFailed => '解析消息失败';
	@override String get notificationParseFailed => '解析通知失败';

	/// Label for current user
	@override String get me => '我';

	/// 以只读模式进入聊天室按钮文本
	@override String get enterReadOnlyMode => '以只读模式进入';

	/// 只读模式提示信息
	@override String get readOnlyModeNotice => '您当前处于只读模式，只能查看消息，无法发送消息';

	/// 只读模式底部提示
	@override String get readOnlyModeTip => '只读模式：您可以查看消息，但无法发送';
}

// Path: profile
class _TranslationsProfileZh implements TranslationsProfileEn {
	_TranslationsProfileZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 个人主页标题
	@override String get profileTitle => '个人主页';

	/// 其他用户主页标题
	@override String get otherProfileTitle => '用户主页';

	/// 编辑按钮文本
	@override String get edit => '编辑';

	/// 保存按钮文本
	@override String get save => '保存';

	/// 加载中提示
	@override String get loading => '加载中...';

	/// 加载失败提示
	@override String get loadingFailed => '加载失败';

	/// 重试按钮文本
	@override String get retry => '重试';

	/// 用户不存在提示
	@override String get userNotFound => '用户不存在';

	/// 未知用户文本
	@override String get unknownUser => '未知用户';

	/// 喜好食物标题
	@override String get foodPreferences => '喜好食物';

	/// 无喜好食物信息提示
	@override String get noFoodPreferences => '暂无喜好食物信息';

	/// 个人简介标题
	@override String get personalBio => '个人简介';

	/// 个人简介输入提示
	@override String get introduceYourself => '介绍一下自己...';

	/// 连接按钮文本
	@override String get connect => 'Connect';

	/// 已关注状态文本
	@override String get following => '已关注';

	/// 保存成功提示
	@override String get saveSuccess => '保存成功';

	/// 保存失败提示
	@override String saveFailed({required String error}) => '保存失败: ${error}';

	/// 关注失败提示
	@override String get followFailed => '关注失败';

	/// 取消关注失败提示
	@override String get unfollowFailed => '取消关注失败';

	/// 推荐餐厅标题
	@override String get recommendedRestaurants => '推荐餐厅';

	/// 我的推荐餐厅标题
	@override String get myRecommendedRestaurants => '我的推荐餐厅';

	/// 用户推荐餐厅标题
	@override String get userRecommendedRestaurants => '用户推荐餐厅';

	/// Prefix when update throws
	@override String get updateFailed => '更新失败';

	/// 编辑个人资料页面标题
	@override String get editProfile => '编辑个人资料';

	/// 邮箱字段标签
	@override String get email => '邮箱';

	/// 用户名字段标签
	@override String get username => '用户名';

	/// 手机号字段标签
	@override String get phone => '手机号';

	/// 更改头像选项标题
	@override String get changeAvatar => '更改头像';

	/// 拍照选项
	@override String get takePhoto => '拍照';

	/// 从相册选择选项
	@override String get selectFromGallery => '从相册选择';

	/// 头像更新成功提示
	@override String get avatarUpdateSuccess => '头像更新成功';

	/// 头像上传失败提示
	@override String avatarUploadFailed({required String error}) => '头像上传失败: ${error}';

	/// 头像更新失败提示
	@override String avatarUpdateFailed({required String error}) => '头像更新失败: ${error}';

	/// 邮箱不可修改提示
	@override String get emailCannotBeChanged => '邮箱地址不可修改';

	/// 用户名输入提示
	@override String get usernameHint => '请输入用户名';

	/// 手机号输入提示
	@override String get phoneHint => '请输入手机号码（可选）';

	/// 保存中提示
	@override String get saving => '保存中...';
}

// Path: restaurant
class _TranslationsRestaurantZh implements TranslationsRestaurantEn {
	_TranslationsRestaurantZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 无餐厅信息提示
	@override String get noRestaurants => '暂无餐厅信息';

	/// 基础信息标题
	@override String get basicInfo => '基础信息';

	/// 地址标签
	@override String get address => '地址';

	/// 距离提示
	@override String distanceFromYou({required String distance}) => '距离您${distance}';

	/// 营业时间标签
	@override String get businessHours => '营业时间';

	/// 电话标签
	@override String get phone => '电话';

	/// 评分标签
	@override String get rating => '评分';

	/// 评价数量提示
	@override String totalReviews({required int count}) => '共${count}条评价';

	/// 餐厅图片标题
	@override String get restaurantImages => '餐厅图片';

	/// 人均消费标题
	@override String get averagePrice => '人均消费';

	/// 推荐菜品标题
	@override String get recommendedDishes => '推荐菜品';

	/// 菜单标题
	@override String get menu => '菜单';

	/// 查看完整菜单文本
	@override String get viewFullMenu => '查看完整菜单';

	/// 查看菜单按钮
	@override String get viewMenu => '查看菜单';

	/// 菜单功能开发中提示
	@override String get menuFeatureInDevelopment => '菜单功能开发中';

	/// 获取菜单失败提示
	@override String get getMenuFailed => '获取菜单失败';

	/// 获取店铺信息失败提示
	@override String get getShopInfoFailed => '获取店铺信息失败';

	/// 餐厅信息无效提示
	@override String get restaurantInfoInvalid => '餐厅信息无效';

	/// 店铺功能标题
	@override String get shopFeatures => '店铺功能';

	/// 查看评论功能标题
	@override String get viewComments => '查看评论';

	/// 查看用户评价描述
	@override String get viewUserReviews => '查看用户评价';

	/// 即时聊天功能标题
	@override String get instantChat => '即时聊天';

	/// 与店员实时交流描述
	@override String get chatWithStaffRealtime => '与店员实时交流';

	/// 查看店员功能标题
	@override String get viewStaff => '查看店员';

	/// 在线店员列表描述
	@override String get onlineStaffList => '在线店员列表';

	/// 查看菜单功能标题
	@override String get viewMenuDishes => '查看菜单';

	/// 浏览所有菜品描述
	@override String get browseAllDishes => '浏览所有菜品';

	/// Hint when RestaurantService.list throws
	@override String loadRestaurantFail({required String error}) => '获取餐厅失败：${error}';

	/// 推荐餐厅按钮提示
	@override String get recommendRestaurant => '推荐餐厅';

	/// 推荐成功提示
	@override String get recommendSuccess => '推荐成功';

	/// 推荐失败提示
	@override String get recommendFailed => '推荐失败：';
}

// Path: review
class _TranslationsReviewZh implements TranslationsReviewEn {
	_TranslationsReviewZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 用户评论标题
	@override String get userComments => '用户评论';

	/// 发布评价按钮
	@override String get publishReview => '发布评价';

	/// 评分标签
	@override String get ratingScore => '评分';

	/// 评价内容标签
	@override String get reviewContent => '评价内容';

	/// 评价内容输入框提示
	@override String get shareDiningExperience => '分享你的用餐体验...';

	/// 添加图片标题
	@override String get addImages => '添加图片';

	/// 拍照按钮
	@override String get takePhoto => '拍照';

	/// 相册按钮
	@override String get selectFromGallery => '相册';

	/// 从相册选择文本
	@override String get selectFromAlbum => '从相册选择';

	/// 添加图片提示
	@override String get addImage => '添加图片';

	/// 发布按钮
	@override String get publish => '发布';

	/// 请输入评价内容提示
	@override String get pleaseEnterReviewContent => '请输入评价内容';

	/// 评价已发布提示
	@override String get reviewPublished => '评价已发布';

	/// 发布失败提示
	@override String get publishFailed => '发布失败';

	/// 拍照失败提示
	@override String get takePhotoFailed => '拍照失败';

	/// 选择图片失败提示
	@override String get selectImageFailed => '选择图片失败';

	/// 无评价提示
	@override String get noReviews => '暂无评价';

	/// 用户评价标题
	@override String get userReviews => '用户评价';

	/// 评价数量
	@override String reviewCount({required int count}) => '${count}条评价';

	/// Error hint when listByRestaurant throws
	@override String loadReviewFail({required String error}) => '获取评论失败：${error}';

	/// Error hint when postReview/postWithImages/postWithImageFiles throws
	@override String postReviewFail({required String error}) => '发布评论失败：${error}';

	/// Dish reviews title
	@override String get dishReviews => '菜品评价';
}

// Path: setting
class _TranslationsSettingZh implements TranslationsSettingEn {
	_TranslationsSettingZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 选择语言标题
	@override String get selectLanguage => '选择语言';

	/// 关闭按钮文本
	@override String get close => '关闭';

	/// 设置标题
	@override String get settings => '设置';

	/// 语言设置标题
	@override String get languageSettings => '语言设置';

	/// 当前语言标签
	@override String get currentLanguage => '当前语言';

	/// 账户设置标题
	@override String get accountSettings => '账户设置';

	/// 个人资料
	@override String get profile => '个人资料';

	/// 隐私设置
	@override String get privacy => '隐私设置';

	/// 通知设置
	@override String get notifications => '通知设置';

	/// 关于
	@override String get about => '关于';

	/// 版本
	@override String get version => '版本';

	/// 退出登录
	@override String get logout => '退出登录';

	/// 确定退出登录提示
	@override String get sureLogout => '确定要退出登录吗？';
}

// Path: staff
class _TranslationsStaffZh implements TranslationsStaffEn {
	_TranslationsStaffZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations

	/// 店员评价标题
	@override String get staffReviews => '店员评价';

	/// 无店员信息提示
	@override String get noStaffInfo => '暂无店员信息';

	/// 查看所有店员按钮
	@override String get viewAllStaff => '查看所有店员';

	/// 经验标签
	@override String get experience => '经验';

	/// 店员列表标题
	@override String get staffList => '店员列表';

	/// 获取店员列表失败提示
	@override String get getStaffListFailed => '获取店员列表失败';

	/// 无店员信息提示
	@override String get noStaff => '暂无店员信息';

	/// 店员详情标题
	@override String get staffDetails => '店员详情';

	/// 店员信息不存在提示
	@override String get staffInfoNotExists => '店员信息不存在';

	/// 获取店员详情失败提示
	@override String get getStaffDetailsFailed => '获取店员详情失败';

	/// 加载店员评价失败提示
	@override String get loadStaffReviewsFailed => '加载店员评价失败';

	/// Error when listByRestaurant throws
	@override String loadStaffFail({required String error}) => '获取店员失败：${error}';

	/// Error when getById throws
	@override String loadStaffDetailFail({required String error}) => '获取店员详情失败：${error}';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.appTitle' => 'FoodieConnect',
			'app.foodieConnect' => 'FoodieConnect',
			'app.discoverFoodShareExperience' => '发现美食，分享体验',
			'app.search' => '搜索',
			'app.home' => '首页',
			'app.loading' => '加载中...',
			'app.loadingFailed' => '加载失败',
			'app.retry' => '重试',
			'app.open' => '营业中',
			'app.closed' => '已打烊',
			'app.userProfile' => '个人主页',
			'app.otherUserProfile' => '用户主页',
			'app.followingList' => '关注列表',
			'app.myFollowing' => '我的关注',
			'app.connect' => 'Connect',
			'app.follow' => '关注',
			'app.following' => '已关注',
			'app.enterReadOnlyMode' => '以只读模式进入',
			'app.readOnlyModeNotice' => '您当前处于只读模式，只能查看消息，无法发送消息',
			'app.readOnlyModeTip' => '只读模式：您可以查看消息，但无法发送',
			'app.unfollow' => '取消关注',
			'app.unfollowConfirm' => ({required Object username}) => '确定要取消关注 ${username} 吗？',
			'app.foodPreferences' => '喜好食物',
			'app.noFoodPreferences' => '暂无喜好食物信息',
			'app.personalBio' => '个人简介',
			'app.noBio' => '这个人很懒，什么都没有留下...',
			'app.recommendedRestaurants' => '推荐餐厅',
			'app.noRecommendedRestaurants' => '暂无推荐餐厅',
			'app.noFollowing' => '暂无关注',
			'app.discoverUsers' => '去发现感兴趣的用户吧',
			'app.save' => '保存',
			'app.edit' => '编辑',
			'app.saveSuccess' => '保存成功',
			'app.saveFailed' => '保存失败',
			'app.followSuccess' => '关注成功',
			'app.followFailed' => '关注失败',
			'app.unfollowSuccess' => '已取消关注',
			'app.unfollowFailed' => '取消关注失败',
			'app.userNotFound' => '用户不存在',
			'app.unknownUser' => '未知用户',
			'app.introduceYourself' => '介绍一下自己...',
			'app.cancel' => '取消',
			'app.recommendations' => '推荐',
			'app.recommendedUsers' => '推荐关注',
			'app.viewMore' => '查看更多',
			'app.noRecommendations' => '暂无推荐用户',
			'app.searchingRecommendations' => '系统正在为您寻找可能感兴趣的用户',
			'app.interested' => '感兴趣',
			'app.notInterested' => '不感兴趣',
			'app.markAsInterested' => '已标记为感兴趣',
			'app.markAsNotInterested' => '已标记为不感兴趣',
			'app.recommendationScore' => '推荐分数',
			'app.recommendationReason' => '推荐理由',
			'app.collaborativeRecommendation' => '基于共同喜好推荐',
			'app.socialRecommendation' => '您关注的人也关注了TA',
			'app.hybridRecommendation' => '综合推荐',
			'app.commonInterests' => ({required String interests}) => '共同喜欢${interests}',
			'app.commonVisits' => ({required int count}) => '共同访问过${count}家餐厅',
			'app.filter' => '筛选',
			'app.sort' => '排序',
			'app.filterByStatus' => '筛选推荐',
			'app.sortBy' => '排序方式',
			'app.all' => '全部',
			'app.unviewed' => '未查看',
			'app.viewed' => '已查看',
			'app.sortByScore' => '推荐分数',
			'app.sortByTime' => '创建时间',
			'app.sortByViewTime' => '查看时间',
			'app.clearAllRecommendations' => '清除所有推荐',
			'app.clearAllConfirm' => '确定要清除所有推荐吗？此操作不可撤销。',
			'app.totalRecommendations' => ({required int count}) => '共 ${count} 个推荐',
			'app.noMoreRecommendations' => '没有更多推荐了',
			'app.recommendationDetail' => '查看推荐详情',
			'app.operationFailed' => ({required String error}) => '操作失败: ${error}',
			'app.discover' => '发现',
			'app.back' => '返回',
			'app.settings' => '设置',
			'app.editProfile' => '编辑资料',
			'app.clearAll' => '清除所有推荐',
			'app.confirm' => '确定',
			'app.commonRestaurants' => '共同餐厅',
			'app.similarity' => '相似度',
			'auth.login' => '登录',
			'auth.register' => '注册',
			'auth.email' => '邮箱地址',
			'auth.password' => '密码',
			'auth.displayName' => '显示名称',
			'auth.phoneNumber' => '手机号码',
			'auth.pleaseEnterEmail' => '请输入邮箱地址',
			'auth.pleaseEnterValidEmail' => '请输入有效的邮箱地址',
			'auth.pleaseEnterPassword' => '请输入密码',
			'auth.passwordMinLength' => '密码至少需要6位字符',
			'auth.forgotPassword' => '忘记密码？',
			'auth.noAccountYet' => '还没有账号？',
			'auth.registerNow' => '立即注册',
			'auth.alreadyHaveAccount' => '已有账号？',
			'auth.loginNow' => '立即登录',
			'auth.createAccount' => '创建账号',
			'auth.joinFoodieConnect' => '加入FoodieConnect，发现更多美食',
			'auth.loginFailed' => '登录失败，请稍后重试',
			'auth.checkingLoginStatus' => '正在检查登录状态...',
			'auth.authCheckFailed' => '认证检查失败',
			'auth.authCheckTimeout' => '认证检查超时',
			'auth.invalidEmailOrPassword' => '邮箱或密码错误',
			'auth.registrationFailed' => '注册失败',
			'auth.logoutFailed' => '登出失败',
			'auth.restoreLoginFailed' => '恢复登录状态失败',
			'auth.loginSuccessful' => '登录成功',
			'auth.registrationSuccessful' => '注册成功',
			'chat.chatRoom' => '聊天室',
			'chat.chatWithStaff' => '与店员实时沟通，了解更多详情',
			'chat.enterChatRoom' => '进入聊天室',
			'chat.restaurantChatVerification' => '餐厅聊天验证',
			'chat.enterRestaurantIdAndCode' => '请输入餐厅ID和验证码以加入聊天室',
			'chat.verificationCode' => '验证码',
			'chat.pleaseEnterVerificationCode' => '请填写验证码',
			'chat.verificationFailed' => '验证失败，请检查餐厅ID和验证码',
			'chat.verificationError' => ({required String error}) => '验证失败：${error}',
			'chat.failedToGetChatRoomInfo' => '获取聊天室信息失败',
			'chat.enterReadOnlyModeError' => '进入只读模式失败：',
			'chat.verifyAndStartChat' => '验证并开始聊天',
			'chat.pleaseVerifyFirst' => '请先通过验证界面加入聊天室',
			'chat.staffChatFeatureMoved' => '店员聊天功能已迁移至餐厅聊天室',
			'chat.restaurantChatRoom' => '餐厅聊天室',
			'chat.initializeChatRoomFailed' => '初始化聊天室失败',
			'chat.initializeChatRoomError' => ({required String error}) => '初始化聊天室失败: ${error}',
			'chat.noAvailableChatRoom' => '当前无可用聊天室',
			'chat.noMessagesStartChat' => '暂无消息，开始聊天吧！',
			'chat.websocketNotConnected' => 'WebSocket未连接',
			'chat.connected' => '已连接',
			'chat.disconnected' => '未连接',
			'chat.enterMessage' => '输入消息...',
			'chat.newMessages' => '新消息',
			'chat.chat' => '聊天',
			'chat.today' => '今天',
			'chat.yesterday' => '昨天',
			'chat.dateFormatThisYear' => ({required int month, required int day}) => '${month}月${day}日',
			'chat.dateFormatOtherYear' => ({required int year, required int month, required int day}) => '${year}年${month}月${day}日',
			'chat.timeFormat' => ({required String hour, required String minute}) => '${hour}:${minute}',
			'chat.stompConnectionError' => ({required String error}) => 'STOMP连接错误：${error}',
			'chat.stompConnectFail' => ({required String error}) => 'STOMP WebSocket连接失败：${error}',
			'chat.websocketTimeout' => 'WebSocket连接超时，请检查网络连接',
			'chat.verifyFailNoRoomOrToken' => '验证失败：未获取到聊天室ID或临时令牌',
			'chat.verifyRoomFail' => ({required String error}) => '验证聊天室失败：${error}',
			'chat.joinRoomFail' => ({required String error}) => '加入聊天室失败：${error}',
			'chat.loadMessageFail' => ({required String error}) => '获取消息失败：${error}',
			'chat.notConnectedCantSend' => 'STOMP WebSocket未连接，无法发送消息',
			'chat.sendMessageFail' => ({required String error}) => '发送消息失败：${error}',
			'chat.leaveRoomFail' => ({required String error}) => '离开聊天室失败：${error}',
			'chat.subscribeNotificationFail' => ({required String error}) => '订阅通知失败：${error}',
			'chat.stompNotConnected' => '未连接，请等待 WebSocket 完成连接',
			'chat.websocketConnecting' => '正在连接WebSocket...',
			'chat.stompConnectFailed' => ({required String error}) => 'WebSocket 连接失败：${error}',
			'chat.stompConnected' => '已连接',
			'chat.stompDisconnected' => '连接已断开',
			'chat.msgParseFailed' => '解析消息失败',
			'chat.notificationParseFailed' => '解析通知失败',
			'chat.me' => '我',
			'chat.enterReadOnlyMode' => '以只读模式进入',
			'chat.readOnlyModeNotice' => '您当前处于只读模式，只能查看消息，无法发送消息',
			'chat.readOnlyModeTip' => '只读模式：您可以查看消息，但无法发送',
			'profile.profileTitle' => '个人主页',
			'profile.otherProfileTitle' => '用户主页',
			'profile.edit' => '编辑',
			'profile.save' => '保存',
			'profile.loading' => '加载中...',
			'profile.loadingFailed' => '加载失败',
			'profile.retry' => '重试',
			'profile.userNotFound' => '用户不存在',
			'profile.unknownUser' => '未知用户',
			'profile.foodPreferences' => '喜好食物',
			'profile.noFoodPreferences' => '暂无喜好食物信息',
			'profile.personalBio' => '个人简介',
			'profile.introduceYourself' => '介绍一下自己...',
			'profile.connect' => 'Connect',
			'profile.following' => '已关注',
			'profile.saveSuccess' => '保存成功',
			'profile.saveFailed' => ({required String error}) => '保存失败: ${error}',
			'profile.followFailed' => '关注失败',
			'profile.unfollowFailed' => '取消关注失败',
			'profile.recommendedRestaurants' => '推荐餐厅',
			'profile.myRecommendedRestaurants' => '我的推荐餐厅',
			'profile.userRecommendedRestaurants' => '用户推荐餐厅',
			'profile.updateFailed' => '更新失败',
			'profile.editProfile' => '编辑个人资料',
			'profile.email' => '邮箱',
			'profile.username' => '用户名',
			'profile.phone' => '手机号',
			'profile.changeAvatar' => '更改头像',
			'profile.takePhoto' => '拍照',
			'profile.selectFromGallery' => '从相册选择',
			'profile.avatarUpdateSuccess' => '头像更新成功',
			'profile.avatarUploadFailed' => ({required String error}) => '头像上传失败: ${error}',
			'profile.avatarUpdateFailed' => ({required String error}) => '头像更新失败: ${error}',
			'profile.emailCannotBeChanged' => '邮箱地址不可修改',
			'profile.usernameHint' => '请输入用户名',
			'profile.phoneHint' => '请输入手机号码（可选）',
			'profile.saving' => '保存中...',
			'restaurant.noRestaurants' => '暂无餐厅信息',
			'restaurant.basicInfo' => '基础信息',
			'restaurant.address' => '地址',
			'restaurant.distanceFromYou' => ({required String distance}) => '距离您${distance}',
			'restaurant.businessHours' => '营业时间',
			'restaurant.phone' => '电话',
			'restaurant.rating' => '评分',
			'restaurant.totalReviews' => ({required int count}) => '共${count}条评价',
			'restaurant.restaurantImages' => '餐厅图片',
			'restaurant.averagePrice' => '人均消费',
			'restaurant.recommendedDishes' => '推荐菜品',
			'restaurant.menu' => '菜单',
			'restaurant.viewFullMenu' => '查看完整菜单',
			'restaurant.viewMenu' => '查看菜单',
			'restaurant.menuFeatureInDevelopment' => '菜单功能开发中',
			'restaurant.getMenuFailed' => '获取菜单失败',
			'restaurant.getShopInfoFailed' => '获取店铺信息失败',
			'restaurant.restaurantInfoInvalid' => '餐厅信息无效',
			'restaurant.shopFeatures' => '店铺功能',
			'restaurant.viewComments' => '查看评论',
			'restaurant.viewUserReviews' => '查看用户评价',
			'restaurant.instantChat' => '即时聊天',
			'restaurant.chatWithStaffRealtime' => '与店员实时交流',
			'restaurant.viewStaff' => '查看店员',
			'restaurant.onlineStaffList' => '在线店员列表',
			'restaurant.viewMenuDishes' => '查看菜单',
			'restaurant.browseAllDishes' => '浏览所有菜品',
			'restaurant.loadRestaurantFail' => ({required String error}) => '获取餐厅失败：${error}',
			'restaurant.recommendRestaurant' => '推荐餐厅',
			'restaurant.recommendSuccess' => '推荐成功',
			'restaurant.recommendFailed' => '推荐失败：',
			'review.userComments' => '用户评论',
			'review.publishReview' => '发布评价',
			'review.ratingScore' => '评分',
			'review.reviewContent' => '评价内容',
			'review.shareDiningExperience' => '分享你的用餐体验...',
			'review.addImages' => '添加图片',
			'review.takePhoto' => '拍照',
			'review.selectFromGallery' => '相册',
			'review.selectFromAlbum' => '从相册选择',
			'review.addImage' => '添加图片',
			'review.publish' => '发布',
			'review.pleaseEnterReviewContent' => '请输入评价内容',
			'review.reviewPublished' => '评价已发布',
			'review.publishFailed' => '发布失败',
			'review.takePhotoFailed' => '拍照失败',
			'review.selectImageFailed' => '选择图片失败',
			'review.noReviews' => '暂无评价',
			'review.userReviews' => '用户评价',
			'review.reviewCount' => ({required int count}) => '${count}条评价',
			'review.loadReviewFail' => ({required String error}) => '获取评论失败：${error}',
			'review.postReviewFail' => ({required String error}) => '发布评论失败：${error}',
			'review.dishReviews' => '菜品评价',
			'setting.selectLanguage' => '选择语言',
			'setting.close' => '关闭',
			'setting.settings' => '设置',
			'setting.languageSettings' => '语言设置',
			'setting.currentLanguage' => '当前语言',
			'setting.accountSettings' => '账户设置',
			'setting.profile' => '个人资料',
			'setting.privacy' => '隐私设置',
			'setting.notifications' => '通知设置',
			'setting.about' => '关于',
			'setting.version' => '版本',
			'setting.logout' => '退出登录',
			'setting.sureLogout' => '确定要退出登录吗？',
			'staff.staffReviews' => '店员评价',
			'staff.noStaffInfo' => '暂无店员信息',
			'staff.viewAllStaff' => '查看所有店员',
			'staff.experience' => '经验',
			'staff.staffList' => '店员列表',
			'staff.getStaffListFailed' => '获取店员列表失败',
			'staff.noStaff' => '暂无店员信息',
			'staff.staffDetails' => '店员详情',
			'staff.staffInfoNotExists' => '店员信息不存在',
			'staff.getStaffDetailsFailed' => '获取店员详情失败',
			'staff.loadStaffReviewsFailed' => '加载店员评价失败',
			'staff.loadStaffFail' => ({required String error}) => '获取店员失败：${error}',
			'staff.loadStaffDetailFail' => ({required String error}) => '获取店员详情失败：${error}',
			_ => null,
		};
	}
}
