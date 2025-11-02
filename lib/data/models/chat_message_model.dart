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