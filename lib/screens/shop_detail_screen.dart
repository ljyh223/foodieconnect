import 'package:flutter/material.dart';
import 'package:tabletalk/generated/translations.g.dart';
import '../data/models/restaurant_model.dart';
import '../data/models/review_model.dart';
import '../data/models/staff_model.dart';
import '../core/services/restaurant_service.dart';
import '../core/services/review_service.dart';
import '../core/services/staff_service.dart';
import '../core/services/api_service.dart';
import 'dart:math';

class ShopDetailScreen extends StatelessWidget {
  final String? restaurantId;
  final Random _random = Random();

  // 随机在线图片列表
  final List<String> _randomImages = [
    'https://picsum.photos/seed/restaurant1/400/300.jpg',
    'https://picsum.photos/seed/restaurant2/400/300.jpg',
    'https://picsum.photos/seed/restaurant3/400/300.jpg',
    'https://picsum.photos/seed/restaurant4/400/300.jpg',
    'https://picsum.photos/seed/restaurant5/400/300.jpg',
    'https://picsum.photos/seed/restaurant6/400/300.jpg',
    'https://picsum.photos/seed/restaurant7/400/300.jpg',
    'https://picsum.photos/seed/restaurant8/400/300.jpg',
  ];

  ShopDetailScreen({super.key, this.restaurantId});

  /// 获取随机图片URL
  String _getRandomImageUrl() {
    return _randomImages[_random.nextInt(_randomImages.length)];
  }

  /// 获取餐厅图片URL，如果没有则使用随机图片
  String _getRestaurantImageUrl(String? avatar) {
    if (avatar != null && avatar.isNotEmpty) {
      return ApiService.getFullImageUrl(avatar);
    }
    return _getRandomImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantId =
        this.restaurantId ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId']
            as String? ??
        '1';

    return FutureBuilder<Restaurant>(
      future: RestaurantService.get(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          debugPrint('获取店铺信息失败：${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('${t.restaurant.getShopInfoFailed}${snapshot.error}'),
            ),
          );
        }

        final restaurant = snapshot.data!;

        void navigateToReviews() {
          Navigator.pushNamed(
            context,
            '/reviews',
            arguments: {'restaurantId': restaurant.id.toString()},
          );
        }

        void navigateToChat() {
          Navigator.pushNamed(
            context,
            '/chat_verify',
            arguments: {'restaurantId': restaurant.id.toString()},
          );
        }

        void navigateToStaff() {
          Navigator.pushNamed(
            context,
            '/staff',
            arguments: {'restaurantId': restaurant.id.toString()},
          );
        }

        void navigateToRestaurantInfo() {
          Navigator.pushNamed(
            context,
            '/restaurant_info',
            arguments: {'restaurantId': restaurant.id.toString()},
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true, // 店名居中
            title: Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 餐厅大图
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        _getRestaurantImageUrl(restaurant.imageUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                restaurant.name.isNotEmpty
                                    ? restaurant.name.substring(0, 1)
                                    : '',
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 基础信息模块 - 无边框
                  GestureDetector(
                    onTap: navigateToRestaurantInfo,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.black,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.restaurant.basicInfo,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // _buildInfoRow(
                          //   icon: Icons.location_on,
                          //   label: t.app.address,
                          //   value: restaurant.address,
                          //   subtitle: t.app.distanceFromYou(restaurant.distance),
                          // ),
                          _buildInfoRow(
                            icon: Icons.schedule,
                            label: t.restaurant.businessHours,
                            value: restaurant.hours,
                          ),
                          _buildInfoRow(
                            icon: Icons.phone,
                            label: t.restaurant.phone,
                            value: restaurant.phone,
                          ),
                          _buildInfoRow(
                            icon: Icons.star,
                            label: t.restaurant.rating,
                            value: '${restaurant.rating}/5.0',
                            subtitle: t.restaurant.totalReviews(
                              count: restaurant.reviewCount,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 菜肴点评模块 - 从接口获取
                  GestureDetector(
                    onTap: navigateToReviews,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.menu_book,
                                color: Colors.black,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.review.dishReviews,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          FutureBuilder<List<Review>>(
                            future: ReviewService.listByRestaurant(
                              restaurant.id.toString(),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.hasError ||
                                  !snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text(
                                  t.review.noReviews,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                );
                              }

                              final reviews = snapshot.data!
                                  .take(3)
                                  .toList(); // 只显示前3条

                              return Column(
                                children: reviews.map((review) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 用户头像
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child: review.userAvatar.isNotEmpty
                                                ? Image.network(
                                                    ApiService.getFullImageUrl(
                                                      review.userAvatar,
                                                    ),
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Center(
                                                            child: Text(
                                                              review
                                                                      .userName
                                                                      .isNotEmpty
                                                                  ? review
                                                                        .userName
                                                                        .substring(
                                                                          0,
                                                                          1,
                                                                        )
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                  )
                                                : Center(
                                                    child: Text(
                                                      review.userName.isNotEmpty
                                                          ? review.userName
                                                                .substring(0, 1)
                                                          : '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        // 评价内容
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    review.userName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Row(
                                                    children: List.generate(5, (
                                                      index,
                                                    ) {
                                                      return Icon(
                                                        index < review.rating
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: Colors.orange,
                                                        size: 14,
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                review.comment,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                  height: 1.4,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 聊天室模块 - 无边框
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              t.chat.chatRoom,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          t.chat.chatWithStaff,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: navigateToChat,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // 使用一致的颜色
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              t.chat.enterChatRoom,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 店员评价模块 - 无边框
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.sentiment_neutral_outlined,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              t.staff.staffReviews,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder<List<Staff>>(
                          future: StaffService.listByRestaurant(
                            restaurant.id.toString(),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Column(
                                children: [
                                  Text(
                                    t.staff.noStaffInfo,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: navigateToStaff,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        t.staff.viewAllStaff,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            final staffList = snapshot.data!
                                .take(3)
                                .toList(); // 只显示前3个店员

                            return Column(
                              children: [
                                // 显示前3个店员
                                ...staffList.map((staff) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 店员头像
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child:
                                                staff.avatarUrl != null &&
                                                    staff.avatarUrl!.isNotEmpty
                                                ? Image.network(
                                                    ApiService.getFullImageUrl(
                                                      staff.avatarUrl!,
                                                    ),
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Center(
                                                            child: Text(
                                                              staff
                                                                      .name
                                                                      .isNotEmpty
                                                                  ? staff.name
                                                                        .substring(
                                                                          0,
                                                                          1,
                                                                        )
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                  )
                                                : Center(
                                                    child: Text(
                                                      staff.name.isNotEmpty
                                                          ? staff.name
                                                                .substring(0, 1)
                                                          : '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        // 店员信息
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    staff.name,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    staff.position,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: List.generate(5, (
                                                      index,
                                                    ) {
                                                      return Icon(
                                                        index < staff.rating
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: Colors.orange,
                                                        size: 14,
                                                      );
                                                    }),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    staff.rating
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (staff
                                                  .experience
                                                  .isNotEmpty) ...[
                                                const SizedBox(height: 2),
                                                Text(
                                                  '${t.staff.experience}：${staff.experience}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),

                                const SizedBox(height: 12),

                                // 查看所有店员按钮
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: navigateToStaff,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      t.staff.viewAllStaff,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 构建信息行
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label：$value',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
