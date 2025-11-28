import 'package:fixnum/fixnum.dart';
import '../../protos/chat_proto.dart';

class ChatMessage {
  final String id;
  final String roomId;
  final String senderId;
  final String content;
  final String messageType; // TEXT, IMAGE, SYSTEM
  final String senderName;
  final String? senderAvatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSentByUser; // 用于UI判断，不是后端字段
  
  ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.messageType,
    required this.senderName,
    this.senderAvatar,
    required this.createdAt,
    required this.updatedAt,
    this.isSentByUser = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, {String? currentUserId}) {
    // 如果提供了当前用户ID，用于判断是否为当前用户发送的消息
    final userId = currentUserId ?? '';
    
    return ChatMessage(
      id: json['id']?.toString() ?? '',
      roomId: json['roomId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      content: json['content'] ?? '',
      messageType: json['messageType'] ?? 'TEXT',
      senderName: json['senderName'] ?? '',
      senderAvatar: json['senderAvatar'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      isSentByUser: json['senderId']?.toString() == userId,
    );
  }

  /// 从protobuf消息创建
  factory ChatMessage.fromProto(ChatMessageProto proto, {String? currentUserId}) {
    final userId = currentUserId ?? '';
    
    return ChatMessage(
      id: proto.id.toString(),
      roomId: proto.roomId.toString(),
      senderId: proto.senderId.toString(),
      content: proto.content,
      messageType: _messageTypeToString(proto.messageType),
      senderName: proto.senderName,
      senderAvatar: proto.senderAvatar,
      createdAt: DateTime.parse(proto.timestamp),
      updatedAt: DateTime.parse(proto.timestamp),
      isSentByUser: proto.senderId.toString() == userId,
    );
  }

  /// 转换为protobuf消息
  ChatMessageProto toProto() {
    return ChatMessageProto(
      id: Int64.parseInt(id),
      roomId: Int64.parseInt(roomId),
      senderId: Int64.parseInt(senderId),
      content: content,
      messageType: _stringToMessageType(messageType),
      senderName: senderName,
      senderAvatar: senderAvatar ?? '',
      timestamp: createdAt.toIso8601String(),
    );
  }

  /// 将字符串转换为MessageType枚举
  static MessageType _stringToMessageType(String type) {
    switch (type.toUpperCase()) {
      case 'TEXT':
        return MessageType.TEXT;
      case 'IMAGE':
        return MessageType.IMAGE;
      case 'SYSTEM':
        return MessageType.SYSTEM;
      default:
        return MessageType.TEXT;
    }
  }

  /// 将MessageType枚举转换为字符串
  static String _messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.TEXT:
        return 'TEXT';
      case MessageType.IMAGE:
        return 'IMAGE';
      case MessageType.SYSTEM:
        return 'SYSTEM';
      default:
        return 'TEXT';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ChatMessage copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? content,
    String? messageType,
    String? senderName,
    String? senderAvatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSentByUser,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSentByUser: isSentByUser ?? this.isSentByUser,
    );
  }
}

class ChatSession {
  final String id;
  final String restaurantId;
  final String staffId;
  final String staffName;
  final String staffAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  
  ChatSession({
    required this.id,
    required this.restaurantId,
    required this.staffId,
    required this.staffName,
    required this.staffAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      staffId: json['staffId'] ?? '',
      staffName: json['staffName'] ?? '',
      staffAvatar: json['staffAvatar'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: DateTime.parse(json['lastMessageTime'] ?? DateTime.now().toIso8601String()),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'staffId': staffId,
      'staffName': staffName,
      'staffAvatar': staffAvatar,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }
}