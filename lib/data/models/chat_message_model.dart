class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isSentByUser;
  final String? staffName;
  final String? staffAvatar;
  
  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isSentByUser,
    this.staffName,
    this.staffAvatar,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isSentByUser: json['isSentByUser'] ?? false,
      staffName: json['staffName'],
      staffAvatar: json['staffAvatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isSentByUser': isSentByUser,
      'staffName': staffName,
      'staffAvatar': staffAvatar,
    };
  }

  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? content,
    DateTime? timestamp,
    bool? isSentByUser,
    String? staffName,
    String? staffAvatar,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isSentByUser: isSentByUser ?? this.isSentByUser,
      staffName: staffName ?? this.staffName,
      staffAvatar: staffAvatar ?? this.staffAvatar,
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