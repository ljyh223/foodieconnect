import '../../data/models/chat_message_model.dart';
import '../../features/chat/chat_repository.dart';

class ChatService {
  static final ChatRepository _repository = ChatRepository();

  /// 验证聊天室验证码并获取临时令牌
  /// 返回包含聊天室信息和临时token的数据
  static Future<Map<String, dynamic>> verifyChatRoom(
    String restaurantId,
    String verificationCode,
  ) async {
    return await _repository.verifyChatRoom(restaurantId, verificationCode);
  }

  /// 以观察者模式加入聊天室（只读模式）
  /// 返回包含聊天室信息和临时token的数据
  static Future<Map<String, dynamic>> joinAsObserver(
    String restaurantId,
  ) async {
    return await _repository.joinAsObserver(restaurantId);
  }

  /// 获取餐厅聊天室信息
  static Future<Map<String, dynamic>> getRestaurantChatRoom(
    String restaurantId,
  ) async {
    return await _repository.getRestaurantChatRoom(restaurantId);
  }

  /// 获取聊天室消息列表
  static Future<List<ChatMessage>> getRoomMessages(
    String roomId, {
    int page = 0,
    int size = 50,
    String? currentUserId,
  }) async {
    return await _repository.getRoomMessages(
      roomId,
      page: page,
      size: size,
      currentUserId: currentUserId,
    );
  }

  /// 发送聊天室消息（HTTP方式，主要用于备份或WebSocket不可用时）
  static Future<ChatMessage> sendRoomMessage(
    String roomId,
    String content,
  ) async {
    return await _repository.sendRoomMessage(roomId, content);
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    await _repository.leaveRoom(roomId);
  }

  /// 获取聊天室信息
  static Future<Map<String, dynamic>> getChatRoomInfo(String roomId) async {
    return await _repository.getChatRoomInfo(roomId);
  }

  /// 获取聊天室成员列表
  static Future<List<Map<String, dynamic>>> getChatRoomMembers(
    String roomId,
  ) async {
    return await _repository.getChatRoomMembers(roomId);
  }
}
