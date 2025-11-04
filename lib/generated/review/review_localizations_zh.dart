// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'review_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ReviewLocalizationsZh extends ReviewLocalizations {
  ReviewLocalizationsZh([String locale = 'zh']) : super(locale);

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
  String get noReviews => '暂无评价';

  @override
  String get userReviews => '用户评价';

  @override
  String reviewCount(int count) {
    return '$count条评价';
  }

  @override
  String loadReviewFail(String error) {
    return '获取评论失败：$error';
  }

  @override
  String postReviewFail(String error) {
    return '发布评论失败：$error';
  }

  @override
  String get dishReviews => '菜品评价';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class ReviewLocalizationsZhTw extends ReviewLocalizationsZh {
  ReviewLocalizationsZhTw() : super('zh_TW');

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
  String get noReviews => '暫無評價';

  @override
  String get userReviews => '用戶評價';

  @override
  String reviewCount(int count) {
    return '$count條評價';
  }

  @override
  String loadReviewFail(String error) {
    return '取得評論失敗：$error';
  }

  @override
  String postReviewFail(String error) {
    return '發布評論失敗：$error';
  }

  @override
  String get dishReviews => '菜肴點評';
}
