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
class TranslationsZhTw with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhTw({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhTw _root = this; // ignore: unused_field

	@override 
	TranslationsZhTw $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhTw(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppZhTw app = _TranslationsAppZhTw._(_root);
	@override late final _TranslationsAuthZhTw auth = _TranslationsAuthZhTw._(_root);
	@override late final _TranslationsChatZhTw chat = _TranslationsChatZhTw._(_root);
	@override late final _TranslationsProfileZhTw profile = _TranslationsProfileZhTw._(_root);
	@override late final _TranslationsRestaurantZhTw restaurant = _TranslationsRestaurantZhTw._(_root);
	@override late final _TranslationsReviewZhTw review = _TranslationsReviewZhTw._(_root);
	@override late final _TranslationsSettingZhTw setting = _TranslationsSettingZhTw._(_root);
	@override late final _TranslationsStaffZhTw staff = _TranslationsStaffZhTw._(_root);
}

// Path: app
class _TranslationsAppZhTw implements TranslationsAppEn {
	_TranslationsAppZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 應用標題
	@override String get appTitle => 'FoodieConnect';

	/// 應用英文名稱
	@override String get foodieConnect => 'Foodie Connect';

	/// 應用中文名稱
	@override String get foodieConnect => 'FoodieConnect';

	/// 應用副標題
	@override String get discoverFoodShareExperience => '發現美食，分享體驗';

	/// 搜尋框提示文本
	@override String get search => '搜尋';

	/// 首頁標籤文字
	@override String get home => '首頁';

	/// 載入中提示
	@override String get loading => '載入中...';

	/// 載入失敗提示
	@override String get loadingFailed => '載入失敗';

	/// 重試按鈕文本
	@override String get retry => '重試';

	/// 營業狀態
	@override String get open => '營業中';

	/// 打烊狀態
	@override String get closed => '已打烊';

	/// 使用者個人資料標題
	@override String get userProfile => '個人資料';

	/// 其他使用者個人資料標題
	@override String get otherUserProfile => '使用者資料';

	/// 追蹤列表標題
	@override String get followingList => '追蹤列表';

	/// 我的追蹤標題
	@override String get myFollowing => '我的追蹤';

	/// 連接按鈕文字
	@override String get connect => '連接';

	/// 關注按鈕文字
	@override String get follow => '關注';

	/// 已追蹤狀態文字
	@override String get following => '已追蹤';

	/// 以唯讀模式進入聊天室按鈕文字
	@override String get enterReadOnlyMode => '以唯讀模式進入';

	/// 唯讀模式提示訊息
	@override String get readOnlyModeNotice => '您目前處於唯讀模式，只能查看訊息，無法發送訊息';

	/// 唯讀模式底部提示
	@override String get readOnlyModeTip => '唯讀模式：您可以查看訊息，但無法發送';

	/// 取消追蹤按鈕文字
	@override String get unfollow => '取消追蹤';

	/// 取消追蹤確認對話框
	@override String unfollowConfirm({required Object username}) => '確定要取消追蹤 ${username} 嗎？';

	/// 飲食偏好標題
	@override String get foodPreferences => '飲食偏好';

	/// 無飲食偏好訊息
	@override String get noFoodPreferences => '無飲食偏好';

	/// 個人簡介標題
	@override String get personalBio => '個人簡介';

	/// 無個人簡介訊息
	@override String get noBio => '這個人太懶了，什麼都沒留下……';

	/// 推薦餐廳標題
	@override String get recommendedRestaurants => '推薦餐廳';

	/// 無推薦餐廳訊息
	@override String get noRecommendedRestaurants => '無推薦餐廳';

	/// 無追蹤對象訊息
	@override String get noFollowing => '尚未追蹤任何人';

	/// 探索使用者提示訊息
	@override String get discoverUsers => '快去探索有趣的使用者吧！';

	/// 儲存按鈕文字
	@override String get save => '儲存';

	/// 編輯按鈕文字
	@override String get edit => '編輯';

	/// 儲存成功訊息
	@override String get saveSuccess => '儲存成功';

	/// 儲存失敗訊息
	@override String get saveFailed => '儲存失敗';

	/// 追蹤成功訊息
	@override String get followSuccess => '追蹤成功';

	/// 追蹤失敗訊息
	@override String get followFailed => '追蹤失敗';

	/// 取消追蹤成功訊息
	@override String get unfollowSuccess => '已取消追蹤';

	/// 取消追蹤失敗訊息
	@override String get unfollowFailed => '取消追蹤失敗';

	/// 使用者不存在訊息
	@override String get userNotFound => '找不到該使用者';

	/// 未知使用者文字
	@override String get unknownUser => '未知使用者';

	/// 個人簡介輸入框提示文字
	@override String get introduceYourself => '告訴我們關於你自己的事……';

	/// 取消按鈕文字
	@override String get cancel => '取消';

	/// 發現頁面標題
	@override String get discover => '發現';

	/// 返回按鈕文字
	@override String get back => '返回';

	/// 設定按鈕文字
	@override String get settings => '設定';

	/// 編輯資料按鈕文字
	@override String get editProfile => '編輯資料';

	/// 清除所有推薦按鈕文字
	@override String get clearAll => '清除所有推薦';

	/// 清除推薦確認對話框內容
	@override String get clearAllConfirm => '確定要清除所有推薦嗎？此操作無法復原。';

	/// 確定按鈕文字
	@override String get confirm => '確定';

	/// 推薦功能標題
	@override String get recommendations => '推薦';

	/// 推薦用戶標題
	@override String get recommendedUsers => '推薦關注';

	/// 查看更多按鈕
	@override String get viewMore => '查看更多';

	/// 無推薦用戶訊息
	@override String get noRecommendations => '暫無推薦用戶';

	/// 搜尋推薦用戶訊息
	@override String get searchingRecommendations => '系統正在為您尋找可能感興趣的用戶';

	/// 感興趣狀態
	@override String get interested => '感興趣';

	/// 不感興趣狀態
	@override String get notInterested => '不感興趣';

	/// 標記感興趣成功訊息
	@override String get markAsInterested => '已標記為感興趣';

	/// 標記不感興趣成功訊息
	@override String get markAsNotInterested => '已標記為不感興趣';

	/// 推薦分數標籤
	@override String get recommendationScore => '推薦分數';

	/// 推薦理由標籤
	@override String get recommendationReason => '推薦理由';

	/// 協同過濾推薦理由
	@override String get collaborativeRecommendation => '基於共同喜好推薦';

	/// 社交推薦理由
	@override String get socialRecommendation => '您關注的人也關注了TA';

	/// 混合推薦理由
	@override String get hybridRecommendation => '綜合推薦';

	/// 共同興趣描述
	@override String commonInterests({required String interests}) => '共同喜歡${interests}';

	/// 共同訪問餐廳描述
	@override String commonVisits({required int count}) => '共同訪問過${count}家餐廳';

	/// 篩選按鈕
	@override String get filter => '篩選';

	/// 排序按鈕
	@override String get sort => '排序';

	/// 篩選對話框標題
	@override String get filterByStatus => '篩選推薦';

	/// 排序對話框標題
	@override String get sortBy => '排序方式';

	/// 全部選項
	@override String get all => '全部';

	/// 未查看狀態
	@override String get unviewed => '未查看';

	/// 已查看狀態
	@override String get viewed => '已查看';

	/// 按分數排序
	@override String get sortByScore => '推薦分數';

	/// 按時間排序
	@override String get sortByTime => '創建時間';

	/// 按查看時間排序
	@override String get sortByViewTime => '查看時間';

	/// 清除所有推薦按鈕
	@override String get clearAllRecommendations => '清除所有推薦';

	/// 推薦總數統計
	@override String totalRecommendations({required int count}) => '共 ${count} 個推薦';

	/// 無更多推薦訊息
	@override String get noMoreRecommendations => '沒有更多推薦了';

	/// 查看推薦詳情訊息
	@override String get recommendationDetail => '查看推薦詳情';

	/// 操作失敗提示
	@override String operationFailed({required String error}) => '操作失敗: ${error}';

	/// 共同餐廳標籤
	@override String get commonRestaurants => '共同餐廳';

	/// 相似度標籤
	@override String get similarity => '相似度';
}

// Path: auth
class _TranslationsAuthZhTw implements TranslationsAuthEn {
	_TranslationsAuthZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 登入按鈕文本
	@override String get login => '登入';

	/// 註冊按鈕文本
	@override String get register => '註冊';

	/// 郵箱輸入框標籤
	@override String get email => '郵箱地址';

	/// 密碼輸入框標籤
	@override String get password => '密碼';

	/// 顯示名稱輸入框標籤
	@override String get displayName => '顯示名稱';

	/// 手機號碼輸入框標籤
	@override String get phoneNumber => '手機號碼';

	/// 郵箱驗證錯誤信息
	@override String get pleaseEnterEmail => '請輸入郵箱地址';

	/// 郵箱格式驗證錯誤信息
	@override String get pleaseEnterValidEmail => '請輸入有效的郵箱地址';

	/// 密碼驗證錯誤信息
	@override String get pleaseEnterPassword => '請輸入密碼';

	/// 密碼長度驗證錯誤信息
	@override String get passwordMinLength => '密碼至少需要6位字符';

	/// 忘記密碼鏈接文本
	@override String get forgotPassword => '忘記密碼？';

	/// 沒有帳號提示文本
	@override String get noAccountYet => '還沒有帳號？';

	/// 立即註冊鏈接文本
	@override String get registerNow => '立即註冊';

	/// 已有帳號提示文本
	@override String get alreadyHaveAccount => '已有帳號？';

	/// 立即登入鏈接文本
	@override String get loginNow => '立即登入';

	/// 創建帳號標題
	@override String get createAccount => '創建帳號';

	/// 註冊頁面副標題
	@override String get joinFoodieConnect => '加入FoodieConnect，發現更多美食';

	/// 登入失敗提示
	@override String get loginFailed => '登入失敗，請稍後重試';

	/// 檢查登入狀態提示
	@override String get checkingLoginStatus => '正在檢查登入狀態...';

	/// 認證檢查失敗提示
	@override String get authCheckFailed => '認證檢查失敗';

	/// 認證檢查超時提示
	@override String get authCheckTimeout => '認證檢查超時';

	/// Error message shown to user
	@override String get invalidEmailOrPassword => '信箱或密碼錯誤';

	/// Prefix when registration throws
	@override String get registrationFailed => '註冊失敗';

	/// Error message shown to user
	@override String get logoutFailed => '登出失敗';

	/// Error message shown to user
	@override String get restoreLoginFailed => '恢復登入狀態失敗';

	/// Login success message
	@override String get loginSuccessful => '登入成功';

	/// Registration success message
	@override String get registrationSuccessful => '註冊成功';
}

// Path: chat
class _TranslationsChatZhTw implements TranslationsChatEn {
	_TranslationsChatZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 聊天室標題
	@override String get chatRoom => '聊天室';

	/// 聊天室描述
	@override String get chatWithStaff => '與店員即時溝通，了解更多詳情';

	/// 進入聊天室按鈕
	@override String get enterChatRoom => '進入聊天室';

	/// 餐廳聊天驗證標題
	@override String get restaurantChatVerification => '餐廳聊天驗證';

	/// 輸入餐廳ID和驗證碼提示
	@override String get enterRestaurantIdAndCode => '請輸入餐廳ID和驗證碼以加入聊天室';

	/// 驗證碼標籤
	@override String get verificationCode => '驗證碼';

	/// 請填寫驗證碼提示
	@override String get pleaseEnterVerificationCode => '請填寫驗證碼';

	/// 驗證失敗提示
	@override String get verificationFailed => '驗證失敗，請檢查餐廳ID和驗證碼';

	/// 驗證錯誤提示
	@override String verificationError({required String error}) => '驗證失敗：${error}';

	/// 獲取聊天室資訊失敗提示
	@override String get failedToGetChatRoomInfo => '獲取聊天室資訊失敗';

	/// 進入唯讀模式失敗提示
	@override String get enterReadOnlyModeError => '進入唯讀模式失敗：';

	/// 驗證並開始聊天按鈕
	@override String get verifyAndStartChat => '驗證並開始聊天';

	/// 請先驗證提示
	@override String get pleaseVerifyFirst => '請先通過驗證界面加入聊天室';

	/// 店員聊天功能遷移提示
	@override String get staffChatFeatureMoved => '店員聊天功能已遷移至餐廳聊天室';

	/// 餐廳聊天室名稱
	@override String get restaurantChatRoom => '餐廳聊天室';

	/// 初始化聊天室失敗提示
	@override String get initializeChatRoomFailed => '初始化聊天室失敗';

	/// 初始化聊天室錯誤提示
	@override String initializeChatRoomError({required String error}) => '初始化聊天室失敗: ${error}';

	/// 無可用聊天室提示
	@override String get noAvailableChatRoom => '當前無可用聊天室';

	/// 無消息提示
	@override String get noMessagesStartChat => '暫無消息，開始聊天吧！';

	/// WebSocket未連接提示
	@override String get websocketNotConnected => 'WebSocket未連接';

	/// 已連接狀態
	@override String get connected => '已連接';

	/// 未連接狀態
	@override String get disconnected => '未連接';

	/// 輸入消息提示
	@override String get enterMessage => '輸入消息...';

	/// 新消息提示
	@override String get newMessages => '新消息';

	/// 聊天標題
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
	@override String stompConnectionError({required String error}) => 'STOMP連線錯誤：${error}';

	/// Toast when initial connect throws
	@override String stompConnectFail({required String error}) => 'STOMP WebSocket連線失敗：${error}';

	/// Hint when waiting for connection timeout
	@override String get websocketTimeout => 'WebSocket連線逾時，請檢查網路連線';

	/// Hint when back-end does not return roomId/tempToken
	@override String get verifyFailNoRoomOrToken => '驗證失敗：未取得聊天室ID或臨時令牌';

	/// Toast when verifyChatRoom API throws
	@override String verifyRoomFail({required String error}) => '驗證聊天室失敗：${error}';

	/// Toast when STOMP joinRoom throws
	@override String joinRoomFail({required String error}) => '加入聊天室失敗：${error}';

	/// Toast when fetchMessages API throws
	@override String loadMessageFail({required String error}) => '取得訊息失敗：${error}';

	/// Toast when sendMessage but socket disconnected
	@override String get notConnectedCantSend => 'STOMP WebSocket未連線，無法發送訊息';

	/// Toast when sendMessage API throws
	@override String sendMessageFail({required String error}) => '發送訊息失敗：${error}';

	/// Toast when leaveRoom API throws
	@override String leaveRoomFail({required String error}) => '離開聊天室失敗：${error}';

	/// Toast when subscribeToNotifications throws
	@override String subscribeNotificationFail({required String error}) => '訂閱通知失敗：${error}';

	/// Thrown when send/join is called before connected
	@override String get stompNotConnected => '未連線，請等待 WebSocket 完成連線';

	/// WebSocket connection status
	@override String get websocketConnecting => '正在連接 WebSocket...';

	/// Connection exception text pushed to connectionStateController
	@override String stompConnectFailed({required String error}) => 'WebSocket 連線失敗：${error}';

	@override String get stompConnected => '已連線';
	@override String get stompDisconnected => '連線已斷開';
	@override String get msgParseFailed => '解析訊息失敗';
	@override String get notificationParseFailed => '解析通知失敗';

	/// Label for current user
	@override String get me => '我';

	/// 以唯讀模式進入聊天室按鈕文字
	@override String get enterReadOnlyMode => '以唯讀模式進入';

	/// 唯讀模式提示訊息
	@override String get readOnlyModeNotice => '您目前處於唯讀模式，只能查看訊息，無法發送訊息';

	/// 唯讀模式底部提示
	@override String get readOnlyModeTip => '唯讀模式：您可以查看訊息，但無法發送';
}

// Path: profile
class _TranslationsProfileZhTw implements TranslationsProfileEn {
	_TranslationsProfileZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 個人主頁標題
	@override String get profileTitle => '個人主頁';

	/// 其他用戶主頁標題
	@override String get otherProfileTitle => '用戶主頁';

	/// 編輯按鈕文本
	@override String get edit => '編輯';

	/// 保存按鈕文本
	@override String get save => '保存';

	/// 載入中提示
	@override String get loading => '載入中...';

	/// 載入失敗提示
	@override String get loadingFailed => '載入失敗';

	/// 重試按鈕文本
	@override String get retry => '重試';

	/// 用戶不存在提示
	@override String get userNotFound => '用戶不存在';

	/// 未知用戶文本
	@override String get unknownUser => '未知用戶';

	/// 喜好食物標題
	@override String get foodPreferences => '喜好食物';

	/// 無喜好食物資訊提示
	@override String get noFoodPreferences => '暫無喜好食物資訊';

	/// 個人簡介標題
	@override String get personalBio => '個人簡介';

	/// 個人簡介輸入提示
	@override String get introduceYourself => '介紹一下自己...';

	/// 連接按鈕文本
	@override String get connect => 'Connect';

	/// 已關注狀態文本
	@override String get following => '已關注';

	/// 保存成功提示
	@override String get saveSuccess => '保存成功';

	/// 保存失敗提示
	@override String saveFailed({required String error}) => '保存失敗: ${error}';

	/// 關注失敗提示
	@override String get followFailed => '關注失敗';

	/// 取消關注失敗提示
	@override String get unfollowFailed => '取消關注失敗';

	/// 推薦餐廳標題
	@override String get recommendedRestaurants => '推薦餐廳';

	/// Prefix when update throws
	@override String get updateFailed => '更新失敗';

	/// 編輯個人資料頁面標題
	@override String get editProfile => '編輯個人資料';

	/// 郵箱字段標籤
	@override String get email => '郵箱';

	/// 用戶名字段標籤
	@override String get username => '用戶名';

	/// 手機號字段標籤
	@override String get phone => '手機號';

	/// 更改頭像選項標題
	@override String get changeAvatar => '更改頭像';

	/// 拍照選項
	@override String get takePhoto => '拍照';

	/// 從相冊選擇選項
	@override String get selectFromGallery => '從相冊選擇';

	/// 頭像更新成功提示
	@override String get avatarUpdateSuccess => '頭像更新成功';

	/// 頭像上傳失敗提示
	@override String avatarUploadFailed({required String error}) => '頭像上傳失敗: ${error}';

	/// 頭像更新失敗提示
	@override String avatarUpdateFailed({required String error}) => '頭像更新失敗: ${error}';

	/// 郵箱不可修改提示
	@override String get emailCannotBeChanged => '郵箱地址不可修改';

	/// 用戶名輸入提示
	@override String get usernameHint => '請輸入用戶名';

	/// 手機號輸入提示
	@override String get phoneHint => '請輸入手機號碼（可選）';

	/// 儲存中提示
	@override String get saving => '儲存中...';
}

// Path: restaurant
class _TranslationsRestaurantZhTw implements TranslationsRestaurantEn {
	_TranslationsRestaurantZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 無餐廳信息提示
	@override String get noRestaurants => '暫無餐廳信息';

	/// 基礎信息標題
	@override String get basicInfo => '基礎信息';

	/// 地址標籤
	@override String get address => '地址';

	/// 距離提示
	@override String distanceFromYou({required String distance}) => '距離您${distance}';

	/// 營業時間標籤
	@override String get businessHours => '營業時間';

	/// 電話標籤
	@override String get phone => '電話';

	/// 評分標籤
	@override String get rating => '評分';

	/// 評價數量提示
	@override String totalReviews({required int count}) => '共${count}條評價';

	/// 餐廳圖片標題
	@override String get restaurantImages => '餐廳圖片';

	/// 人均消費標題
	@override String get averagePrice => '人均消費';

	/// 推薦菜品標題
	@override String get recommendedDishes => '推薦菜品';

	/// 菜單標題
	@override String get menu => '菜單';

	/// 查看完整菜單文本
	@override String get viewFullMenu => '查看完整菜單';

	/// 查看菜單按鈕
	@override String get viewMenu => '查看菜單';

	/// 菜單功能開發中提示
	@override String get menuFeatureInDevelopment => '菜單功能開發中';

	/// 獲取菜單失敗提示
	@override String get getMenuFailed => '獲取菜單失敗';

	/// 獲取店鋪信息失敗提示
	@override String get getShopInfoFailed => '獲取店鋪信息失敗';

	/// 餐廳信息無效提示
	@override String get restaurantInfoInvalid => '餐廳信息無效';

	/// 店鋪功能標題
	@override String get shopFeatures => '店鋪功能';

	/// 查看評論功能標題
	@override String get viewComments => '查看評論';

	/// 查看用戶評價描述
	@override String get viewUserReviews => '查看用戶評價';

	/// 即時聊天功能標題
	@override String get instantChat => '即時聊天';

	/// 與店員即時交流描述
	@override String get chatWithStaffRealtime => '與店員即時交流';

	/// 查看店員功能標題
	@override String get viewStaff => '查看店員';

	/// 在線店員列表描述
	@override String get onlineStaffList => '在線店員列表';

	/// 查看菜單功能標題
	@override String get viewMenuDishes => '查看菜單';

	/// 瀏覽所有菜品描述
	@override String get browseAllDishes => '瀏覽所有菜品';

	/// Hint when RestaurantService.list throws
	@override String loadRestaurantFail({required String error}) => '取得餐廳失敗：${error}';
}

// Path: review
class _TranslationsReviewZhTw implements TranslationsReviewEn {
	_TranslationsReviewZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 用戶評論標題
	@override String get userComments => '用戶評論';

	/// 發布評價按鈕
	@override String get publishReview => '發布評價';

	/// 評分標籤
	@override String get ratingScore => '評分';

	/// 評價內容標籤
	@override String get reviewContent => '評價內容';

	/// 評價內容輸入框提示
	@override String get shareDiningExperience => '分享你的用餐體驗...';

	/// 添加圖片標題
	@override String get addImages => '添加圖片';

	/// 拍照按鈕
	@override String get takePhoto => '拍照';

	/// 相冊按鈕
	@override String get selectFromGallery => '相冊';

	/// 從相冊選擇文本
	@override String get selectFromAlbum => '從相冊選擇';

	/// 添加圖片提示
	@override String get addImage => '添加圖片';

	/// 發布按鈕
	@override String get publish => '發布';

	/// 請輸入評價內容提示
	@override String get pleaseEnterReviewContent => '請輸入評價內容';

	/// 評價已發布提示
	@override String get reviewPublished => '評價已發布';

	/// 發布失敗提示
	@override String get publishFailed => '發布失敗';

	/// 拍照失敗提示
	@override String get takePhotoFailed => '拍照失敗';

	/// 選擇圖片失敗提示
	@override String get selectImageFailed => '選擇圖片失敗';

	/// 無評價提示
	@override String get noReviews => '暫無評價';

	/// 用戶評價標題
	@override String get userReviews => '用戶評價';

	/// 評價數量
	@override String reviewCount({required int count}) => '${count}條評價';

	/// Error hint when listByRestaurant throws
	@override String loadReviewFail({required String error}) => '取得評論失敗：${error}';

	/// Error hint when postReview/postWithImages/postWithImageFiles throws
	@override String postReviewFail({required String error}) => '發布評論失敗：${error}';

	/// 菜肴點評標題
	@override String get dishReviews => '菜肴點評';
}

// Path: setting
class _TranslationsSettingZhTw implements TranslationsSettingEn {
	_TranslationsSettingZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 選擇語言標題
	@override String get selectLanguage => '選擇語言';

	/// 關閉按鈕文本
	@override String get close => '關閉';

	/// 設定標題
	@override String get settings => '設定';

	/// 語言設定標題
	@override String get languageSettings => '語言設定';

	/// 當前語言標籤
	@override String get currentLanguage => '當前語言';

	/// 帳戶設定標題
	@override String get accountSettings => '帳戶設定';

	/// 個人資料
	@override String get profile => '個人資料';

	/// 隱私設定
	@override String get privacy => '隱私設定';

	/// 通知設定
	@override String get notifications => '通知設定';

	/// 關於
	@override String get about => '關於';

	/// 版本
	@override String get version => '版本';

	/// 登出
	@override String get logout => '登出';

	/// 確定退出登錄提示
	@override String get sureLogout => '確定要退出登錄嗎？';
}

// Path: staff
class _TranslationsStaffZhTw implements TranslationsStaffEn {
	_TranslationsStaffZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations

	/// 店員評價標題
	@override String get staffReviews => '店員評價';

	/// 無店員信息提示
	@override String get noStaffInfo => '暫無店員信息';

	/// 查看所有店員按鈕
	@override String get viewAllStaff => '查看所有店員';

	/// 經驗標籤
	@override String get experience => '經驗';

	/// 店員列表標題
	@override String get staffList => '店員列表';

	/// 獲取店員列表失敗提示
	@override String get getStaffListFailed => '獲取店員列表失敗';

	/// 無店員信息提示
	@override String get noStaff => '暫無店員信息';

	/// 店員詳情標題
	@override String get staffDetails => '店員詳情';

	/// 店員信息不存在提示
	@override String get staffInfoNotExists => '店員信息不存在';

	/// 獲取店員詳情失敗提示
	@override String get getStaffDetailsFailed => '獲取店員詳情失敗';

	/// 載入店員評價失敗提示
	@override String get loadStaffReviewsFailed => '載入店員評價失敗';

	/// Error when listByRestaurant throws
	@override String loadStaffFail({required String error}) => '取得店員失敗：${error}';

	/// Error when getById throws
	@override String loadStaffDetailFail({required String error}) => '取得店員詳情失敗：${error}';
}

/// The flat map containing all translations for locale <zh-TW>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.appTitle' => 'FoodieConnect',
			'app.foodieConnect' => 'Foodie Connect',
			'app.foodieConnect' => 'FoodieConnect',
			'app.discoverFoodShareExperience' => '發現美食，分享體驗',
			'app.search' => '搜尋',
			'app.home' => '首頁',
			'app.loading' => '載入中...',
			'app.loadingFailed' => '載入失敗',
			'app.retry' => '重試',
			'app.open' => '營業中',
			'app.closed' => '已打烊',
			'app.userProfile' => '個人資料',
			'app.otherUserProfile' => '使用者資料',
			'app.followingList' => '追蹤列表',
			'app.myFollowing' => '我的追蹤',
			'app.connect' => '連接',
			'app.follow' => '關注',
			'app.following' => '已追蹤',
			'app.enterReadOnlyMode' => '以唯讀模式進入',
			'app.readOnlyModeNotice' => '您目前處於唯讀模式，只能查看訊息，無法發送訊息',
			'app.readOnlyModeTip' => '唯讀模式：您可以查看訊息，但無法發送',
			'app.unfollow' => '取消追蹤',
			'app.unfollowConfirm' => ({required Object username}) => '確定要取消追蹤 ${username} 嗎？',
			'app.foodPreferences' => '飲食偏好',
			'app.noFoodPreferences' => '無飲食偏好',
			'app.personalBio' => '個人簡介',
			'app.noBio' => '這個人太懶了，什麼都沒留下……',
			'app.recommendedRestaurants' => '推薦餐廳',
			'app.noRecommendedRestaurants' => '無推薦餐廳',
			'app.noFollowing' => '尚未追蹤任何人',
			'app.discoverUsers' => '快去探索有趣的使用者吧！',
			'app.save' => '儲存',
			'app.edit' => '編輯',
			'app.saveSuccess' => '儲存成功',
			'app.saveFailed' => '儲存失敗',
			'app.followSuccess' => '追蹤成功',
			'app.followFailed' => '追蹤失敗',
			'app.unfollowSuccess' => '已取消追蹤',
			'app.unfollowFailed' => '取消追蹤失敗',
			'app.userNotFound' => '找不到該使用者',
			'app.unknownUser' => '未知使用者',
			'app.introduceYourself' => '告訴我們關於你自己的事……',
			'app.cancel' => '取消',
			'app.discover' => '發現',
			'app.back' => '返回',
			'app.settings' => '設定',
			'app.editProfile' => '編輯資料',
			'app.clearAll' => '清除所有推薦',
			'app.clearAllConfirm' => '確定要清除所有推薦嗎？此操作無法復原。',
			'app.confirm' => '確定',
			'app.recommendations' => '推薦',
			'app.recommendedUsers' => '推薦關注',
			'app.viewMore' => '查看更多',
			'app.noRecommendations' => '暫無推薦用戶',
			'app.searchingRecommendations' => '系統正在為您尋找可能感興趣的用戶',
			'app.interested' => '感興趣',
			'app.notInterested' => '不感興趣',
			'app.markAsInterested' => '已標記為感興趣',
			'app.markAsNotInterested' => '已標記為不感興趣',
			'app.recommendationScore' => '推薦分數',
			'app.recommendationReason' => '推薦理由',
			'app.collaborativeRecommendation' => '基於共同喜好推薦',
			'app.socialRecommendation' => '您關注的人也關注了TA',
			'app.hybridRecommendation' => '綜合推薦',
			'app.commonInterests' => ({required String interests}) => '共同喜歡${interests}',
			'app.commonVisits' => ({required int count}) => '共同訪問過${count}家餐廳',
			'app.filter' => '篩選',
			'app.sort' => '排序',
			'app.filterByStatus' => '篩選推薦',
			'app.sortBy' => '排序方式',
			'app.all' => '全部',
			'app.unviewed' => '未查看',
			'app.viewed' => '已查看',
			'app.sortByScore' => '推薦分數',
			'app.sortByTime' => '創建時間',
			'app.sortByViewTime' => '查看時間',
			'app.clearAllRecommendations' => '清除所有推薦',
			'app.totalRecommendations' => ({required int count}) => '共 ${count} 個推薦',
			'app.noMoreRecommendations' => '沒有更多推薦了',
			'app.recommendationDetail' => '查看推薦詳情',
			'app.operationFailed' => ({required String error}) => '操作失敗: ${error}',
			'app.commonRestaurants' => '共同餐廳',
			'app.similarity' => '相似度',
			'auth.login' => '登入',
			'auth.register' => '註冊',
			'auth.email' => '郵箱地址',
			'auth.password' => '密碼',
			'auth.displayName' => '顯示名稱',
			'auth.phoneNumber' => '手機號碼',
			'auth.pleaseEnterEmail' => '請輸入郵箱地址',
			'auth.pleaseEnterValidEmail' => '請輸入有效的郵箱地址',
			'auth.pleaseEnterPassword' => '請輸入密碼',
			'auth.passwordMinLength' => '密碼至少需要6位字符',
			'auth.forgotPassword' => '忘記密碼？',
			'auth.noAccountYet' => '還沒有帳號？',
			'auth.registerNow' => '立即註冊',
			'auth.alreadyHaveAccount' => '已有帳號？',
			'auth.loginNow' => '立即登入',
			'auth.createAccount' => '創建帳號',
			'auth.joinFoodieConnect' => '加入FoodieConnect，發現更多美食',
			'auth.loginFailed' => '登入失敗，請稍後重試',
			'auth.checkingLoginStatus' => '正在檢查登入狀態...',
			'auth.authCheckFailed' => '認證檢查失敗',
			'auth.authCheckTimeout' => '認證檢查超時',
			'auth.invalidEmailOrPassword' => '信箱或密碼錯誤',
			'auth.registrationFailed' => '註冊失敗',
			'auth.logoutFailed' => '登出失敗',
			'auth.restoreLoginFailed' => '恢復登入狀態失敗',
			'auth.loginSuccessful' => '登入成功',
			'auth.registrationSuccessful' => '註冊成功',
			'chat.chatRoom' => '聊天室',
			'chat.chatWithStaff' => '與店員即時溝通，了解更多詳情',
			'chat.enterChatRoom' => '進入聊天室',
			'chat.restaurantChatVerification' => '餐廳聊天驗證',
			'chat.enterRestaurantIdAndCode' => '請輸入餐廳ID和驗證碼以加入聊天室',
			'chat.verificationCode' => '驗證碼',
			'chat.pleaseEnterVerificationCode' => '請填寫驗證碼',
			'chat.verificationFailed' => '驗證失敗，請檢查餐廳ID和驗證碼',
			'chat.verificationError' => ({required String error}) => '驗證失敗：${error}',
			'chat.failedToGetChatRoomInfo' => '獲取聊天室資訊失敗',
			'chat.enterReadOnlyModeError' => '進入唯讀模式失敗：',
			'chat.verifyAndStartChat' => '驗證並開始聊天',
			'chat.pleaseVerifyFirst' => '請先通過驗證界面加入聊天室',
			'chat.staffChatFeatureMoved' => '店員聊天功能已遷移至餐廳聊天室',
			'chat.restaurantChatRoom' => '餐廳聊天室',
			'chat.initializeChatRoomFailed' => '初始化聊天室失敗',
			'chat.initializeChatRoomError' => ({required String error}) => '初始化聊天室失敗: ${error}',
			'chat.noAvailableChatRoom' => '當前無可用聊天室',
			'chat.noMessagesStartChat' => '暫無消息，開始聊天吧！',
			'chat.websocketNotConnected' => 'WebSocket未連接',
			'chat.connected' => '已連接',
			'chat.disconnected' => '未連接',
			'chat.enterMessage' => '輸入消息...',
			'chat.newMessages' => '新消息',
			'chat.chat' => '聊天',
			'chat.today' => '今天',
			'chat.yesterday' => '昨天',
			'chat.dateFormatThisYear' => ({required int month, required int day}) => '${month}月${day}日',
			'chat.dateFormatOtherYear' => ({required int year, required int month, required int day}) => '${year}年${month}月${day}日',
			'chat.timeFormat' => ({required String hour, required String minute}) => '${hour}:${minute}',
			'chat.stompConnectionError' => ({required String error}) => 'STOMP連線錯誤：${error}',
			'chat.stompConnectFail' => ({required String error}) => 'STOMP WebSocket連線失敗：${error}',
			'chat.websocketTimeout' => 'WebSocket連線逾時，請檢查網路連線',
			'chat.verifyFailNoRoomOrToken' => '驗證失敗：未取得聊天室ID或臨時令牌',
			'chat.verifyRoomFail' => ({required String error}) => '驗證聊天室失敗：${error}',
			'chat.joinRoomFail' => ({required String error}) => '加入聊天室失敗：${error}',
			'chat.loadMessageFail' => ({required String error}) => '取得訊息失敗：${error}',
			'chat.notConnectedCantSend' => 'STOMP WebSocket未連線，無法發送訊息',
			'chat.sendMessageFail' => ({required String error}) => '發送訊息失敗：${error}',
			'chat.leaveRoomFail' => ({required String error}) => '離開聊天室失敗：${error}',
			'chat.subscribeNotificationFail' => ({required String error}) => '訂閱通知失敗：${error}',
			'chat.stompNotConnected' => '未連線，請等待 WebSocket 完成連線',
			'chat.websocketConnecting' => '正在連接 WebSocket...',
			'chat.stompConnectFailed' => ({required String error}) => 'WebSocket 連線失敗：${error}',
			'chat.stompConnected' => '已連線',
			'chat.stompDisconnected' => '連線已斷開',
			'chat.msgParseFailed' => '解析訊息失敗',
			'chat.notificationParseFailed' => '解析通知失敗',
			'chat.me' => '我',
			'chat.enterReadOnlyMode' => '以唯讀模式進入',
			'chat.readOnlyModeNotice' => '您目前處於唯讀模式，只能查看訊息，無法發送訊息',
			'chat.readOnlyModeTip' => '唯讀模式：您可以查看訊息，但無法發送',
			'profile.profileTitle' => '個人主頁',
			'profile.otherProfileTitle' => '用戶主頁',
			'profile.edit' => '編輯',
			'profile.save' => '保存',
			'profile.loading' => '載入中...',
			'profile.loadingFailed' => '載入失敗',
			'profile.retry' => '重試',
			'profile.userNotFound' => '用戶不存在',
			'profile.unknownUser' => '未知用戶',
			'profile.foodPreferences' => '喜好食物',
			'profile.noFoodPreferences' => '暫無喜好食物資訊',
			'profile.personalBio' => '個人簡介',
			'profile.introduceYourself' => '介紹一下自己...',
			'profile.connect' => 'Connect',
			'profile.following' => '已關注',
			'profile.saveSuccess' => '保存成功',
			'profile.saveFailed' => ({required String error}) => '保存失敗: ${error}',
			'profile.followFailed' => '關注失敗',
			'profile.unfollowFailed' => '取消關注失敗',
			'profile.recommendedRestaurants' => '推薦餐廳',
			'profile.updateFailed' => '更新失敗',
			'profile.editProfile' => '編輯個人資料',
			'profile.email' => '郵箱',
			'profile.username' => '用戶名',
			'profile.phone' => '手機號',
			'profile.changeAvatar' => '更改頭像',
			'profile.takePhoto' => '拍照',
			'profile.selectFromGallery' => '從相冊選擇',
			'profile.avatarUpdateSuccess' => '頭像更新成功',
			'profile.avatarUploadFailed' => ({required String error}) => '頭像上傳失敗: ${error}',
			'profile.avatarUpdateFailed' => ({required String error}) => '頭像更新失敗: ${error}',
			'profile.emailCannotBeChanged' => '郵箱地址不可修改',
			'profile.usernameHint' => '請輸入用戶名',
			'profile.phoneHint' => '請輸入手機號碼（可選）',
			'profile.saving' => '儲存中...',
			'restaurant.noRestaurants' => '暫無餐廳信息',
			'restaurant.basicInfo' => '基礎信息',
			'restaurant.address' => '地址',
			'restaurant.distanceFromYou' => ({required String distance}) => '距離您${distance}',
			'restaurant.businessHours' => '營業時間',
			'restaurant.phone' => '電話',
			'restaurant.rating' => '評分',
			'restaurant.totalReviews' => ({required int count}) => '共${count}條評價',
			'restaurant.restaurantImages' => '餐廳圖片',
			'restaurant.averagePrice' => '人均消費',
			'restaurant.recommendedDishes' => '推薦菜品',
			'restaurant.menu' => '菜單',
			'restaurant.viewFullMenu' => '查看完整菜單',
			'restaurant.viewMenu' => '查看菜單',
			'restaurant.menuFeatureInDevelopment' => '菜單功能開發中',
			'restaurant.getMenuFailed' => '獲取菜單失敗',
			'restaurant.getShopInfoFailed' => '獲取店鋪信息失敗',
			'restaurant.restaurantInfoInvalid' => '餐廳信息無效',
			'restaurant.shopFeatures' => '店鋪功能',
			'restaurant.viewComments' => '查看評論',
			'restaurant.viewUserReviews' => '查看用戶評價',
			'restaurant.instantChat' => '即時聊天',
			'restaurant.chatWithStaffRealtime' => '與店員即時交流',
			'restaurant.viewStaff' => '查看店員',
			'restaurant.onlineStaffList' => '在線店員列表',
			'restaurant.viewMenuDishes' => '查看菜單',
			'restaurant.browseAllDishes' => '瀏覽所有菜品',
			'restaurant.loadRestaurantFail' => ({required String error}) => '取得餐廳失敗：${error}',
			'review.userComments' => '用戶評論',
			'review.publishReview' => '發布評價',
			'review.ratingScore' => '評分',
			'review.reviewContent' => '評價內容',
			'review.shareDiningExperience' => '分享你的用餐體驗...',
			'review.addImages' => '添加圖片',
			'review.takePhoto' => '拍照',
			'review.selectFromGallery' => '相冊',
			'review.selectFromAlbum' => '從相冊選擇',
			'review.addImage' => '添加圖片',
			'review.publish' => '發布',
			'review.pleaseEnterReviewContent' => '請輸入評價內容',
			'review.reviewPublished' => '評價已發布',
			'review.publishFailed' => '發布失敗',
			'review.takePhotoFailed' => '拍照失敗',
			'review.selectImageFailed' => '選擇圖片失敗',
			'review.noReviews' => '暫無評價',
			'review.userReviews' => '用戶評價',
			'review.reviewCount' => ({required int count}) => '${count}條評價',
			'review.loadReviewFail' => ({required String error}) => '取得評論失敗：${error}',
			'review.postReviewFail' => ({required String error}) => '發布評論失敗：${error}',
			'review.dishReviews' => '菜肴點評',
			'setting.selectLanguage' => '選擇語言',
			'setting.close' => '關閉',
			'setting.settings' => '設定',
			'setting.languageSettings' => '語言設定',
			'setting.currentLanguage' => '當前語言',
			'setting.accountSettings' => '帳戶設定',
			'setting.profile' => '個人資料',
			'setting.privacy' => '隱私設定',
			'setting.notifications' => '通知設定',
			'setting.about' => '關於',
			'setting.version' => '版本',
			'setting.logout' => '登出',
			'setting.sureLogout' => '確定要退出登錄嗎？',
			'staff.staffReviews' => '店員評價',
			'staff.noStaffInfo' => '暫無店員信息',
			'staff.viewAllStaff' => '查看所有店員',
			'staff.experience' => '經驗',
			'staff.staffList' => '店員列表',
			'staff.getStaffListFailed' => '獲取店員列表失敗',
			'staff.noStaff' => '暫無店員信息',
			'staff.staffDetails' => '店員詳情',
			'staff.staffInfoNotExists' => '店員信息不存在',
			'staff.getStaffDetailsFailed' => '獲取店員詳情失敗',
			'staff.loadStaffReviewsFailed' => '載入店員評價失敗',
			'staff.loadStaffFail' => ({required String error}) => '取得店員失敗：${error}',
			'staff.loadStaffDetailFail' => ({required String error}) => '取得店員詳情失敗：${error}',
			_ => null,
		};
	}
}
