import 'dart:typed_data';
import 'package:fixnum/fixnum.dart';
import 'package:tabletalk/data/models/chat_message_model.dart';
import 'chat.pb.dart' as $pb;

/// Protobuf消息类型枚举
enum MessageType {
  TEXT,
  IMAGE,
  SYSTEM,
}

/// Protobuf聊天消息类
class ChatMessageProto {
  final Int64 id;
  final Int64 roomId;
  final Int64 senderId;
  final String content;
  final MessageType messageType;
  final String senderName;
  final String senderAvatar;
  final String timestamp;

  ChatMessageProto({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.messageType,
    required this.senderName,
    required this.senderAvatar,
    required this.timestamp,
  });

  /// 从protobuf消息创建
  factory ChatMessageProto.fromProto($pb.ChatMessage proto) {
    return ChatMessageProto(
      id: proto.id,
      roomId: proto.roomId,
      senderId: proto.senderId,
      content: proto.content,
      messageType: _messageTypeFromProto(proto.messageType),
      senderName: proto.senderName,
      senderAvatar: proto.senderAvatar,
      timestamp: proto.timestamp,
    );
  }

  /// 转换为protobuf消息
  $pb.ChatMessage toProto() {
    return $pb.ChatMessage()
      ..id = id
      ..roomId = roomId
      ..senderId = senderId
      ..content = content
      ..messageType = _messageTypeToProto(messageType)
      ..senderName = senderName
      ..senderAvatar = senderAvatar
      ..timestamp = timestamp;
  }

  /// 从二进制数据创建
  factory ChatMessageProto.fromBuffer(Uint8List data) {
    final proto = $pb.ChatMessage.fromBuffer(data);
    return ChatMessageProto.fromProto(proto);
  }

  /// 转换为二进制数据
  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }

  /// 转换为ChatMessage模型
  ChatMessage toModel({String? currentUserId}) {
    return ChatMessage(
      id: id.toString(),
      roomId: roomId.toString(),
      senderId: senderId.toString(),
      content: content,
      messageType: _messageTypeToString(messageType),
      senderName: senderName,
      senderAvatar: senderAvatar,
      createdAt: DateTime.parse(timestamp),
      updatedAt: DateTime.parse(timestamp),
      isSentByUser: senderId.toString() == currentUserId,
    );
  }

  static MessageType _messageTypeFromProto($pb.MessageType protoType) {
    switch (protoType) {
      case $pb.MessageType.TEXT:
        return MessageType.TEXT;
      case $pb.MessageType.IMAGE:
        return MessageType.IMAGE;
      case $pb.MessageType.SYSTEM:
        return MessageType.SYSTEM;
      default:
        return MessageType.TEXT;
    }
  }

  static $pb.MessageType _messageTypeToProto(MessageType type) {
    switch (type) {
      case MessageType.TEXT:
        return $pb.MessageType.TEXT;
      case MessageType.IMAGE:
        return $pb.MessageType.IMAGE;
      case MessageType.SYSTEM:
        return $pb.MessageType.SYSTEM;
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
}

/// 发送消息请求
class SendMessageRequestProto {
  final Int64 roomId;
  final String content;

  SendMessageRequestProto({
    required this.roomId,
    required this.content,
  });

  factory SendMessageRequestProto.fromProto($pb.SendMessageRequest proto) {
    return SendMessageRequestProto(
      roomId: proto.roomId,
      content: proto.content,
    );
  }

  $pb.SendMessageRequest toProto() {
    return $pb.SendMessageRequest()
      ..roomId = roomId
      ..content = content;
  }

  factory SendMessageRequestProto.fromBuffer(Uint8List data) {
    final proto = $pb.SendMessageRequest.fromBuffer(data);
    return SendMessageRequestProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// 加入房间请求
class JoinRoomRequestProto {
  final Int64 roomId;

  JoinRoomRequestProto({
    required this.roomId,
  });

  factory JoinRoomRequestProto.fromProto($pb.JoinRoomRequest proto) {
    return JoinRoomRequestProto(
      roomId: proto.roomId,
    );
  }

  $pb.JoinRoomRequest toProto() {
    return $pb.JoinRoomRequest()
      ..roomId = roomId;
  }

  factory JoinRoomRequestProto.fromBuffer(Uint8List data) {
    final proto = $pb.JoinRoomRequest.fromBuffer(data);
    return JoinRoomRequestProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// 离开房间请求
class LeaveRoomRequestProto {
  final Int64 roomId;

  LeaveRoomRequestProto({
    required this.roomId,
  });

  factory LeaveRoomRequestProto.fromProto($pb.LeaveRoomRequest proto) {
    return LeaveRoomRequestProto(
      roomId: proto.roomId,
    );
  }

  $pb.LeaveRoomRequest toProto() {
    return $pb.LeaveRoomRequest()
      ..roomId = roomId;
  }

  factory LeaveRoomRequestProto.fromBuffer(Uint8List data) {
    final proto = $pb.LeaveRoomRequest.fromBuffer(data);
    return LeaveRoomRequestProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// 通用聊天响应
class ChatResponseProto {
  final bool success;
  final String errorMessage;
  final dynamic payload; // ChatMessageProto, JoinRoomResponseProto, or LeaveRoomResponseProto

  ChatResponseProto({
    required this.success,
    required this.errorMessage,
    this.payload,
  });

  factory ChatResponseProto.fromProto($pb.ChatResponse proto) {
    dynamic payload;
    switch (proto.whichPayload()) {
      case $pb.ChatResponse_Payload.message:
        payload = ChatMessageProto.fromProto(proto.message);
        break;
      case $pb.ChatResponse_Payload.joinResponse:
        payload = JoinRoomResponseProto.fromProto(proto.joinResponse);
        break;
      case $pb.ChatResponse_Payload.leaveResponse:
        payload = LeaveRoomResponseProto.fromProto(proto.leaveResponse);
        break;
      case $pb.ChatResponse_Payload.notSet:
      default:
        payload = null;
        break;
    }

    return ChatResponseProto(
      success: proto.success,
      errorMessage: proto.errorMessage,
      payload: payload,
    );
  }

  $pb.ChatResponse toProto() {
    final proto = $pb.ChatResponse()
      ..success = success
      ..errorMessage = errorMessage;

    if (payload is ChatMessageProto) {
      proto.message = (payload as ChatMessageProto).toProto();
    } else if (payload is JoinRoomResponseProto) {
      proto.joinResponse = (payload as JoinRoomResponseProto).toProto();
    } else if (payload is LeaveRoomResponseProto) {
      proto.leaveResponse = (payload as LeaveRoomResponseProto).toProto();
    }

    return proto;
  }

  factory ChatResponseProto.fromBuffer(Uint8List data) {
    final proto = $pb.ChatResponse.fromBuffer(data);
    return ChatResponseProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// 加入房间响应
class JoinRoomResponseProto {
  final bool success;
  final String message;

  JoinRoomResponseProto({
    required this.success,
    required this.message,
  });

  factory JoinRoomResponseProto.fromProto($pb.JoinRoomResponse proto) {
    return JoinRoomResponseProto(
      success: proto.success,
      message: proto.message,
    );
  }

  $pb.JoinRoomResponse toProto() {
    return $pb.JoinRoomResponse()
      ..success = success
      ..message = message;
  }

  factory JoinRoomResponseProto.fromBuffer(Uint8List data) {
    final proto = $pb.JoinRoomResponse.fromBuffer(data);
    return JoinRoomResponseProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// 离开房间响应
class LeaveRoomResponseProto {
  final bool success;
  final String message;

  LeaveRoomResponseProto({
    required this.success,
    required this.message,
  });

  factory LeaveRoomResponseProto.fromProto($pb.LeaveRoomResponse proto) {
    return LeaveRoomResponseProto(
      success: proto.success,
      message: proto.message,
    );
  }

  $pb.LeaveRoomResponse toProto() {
    return $pb.LeaveRoomResponse()
      ..success = success
      ..message = message;
  }

  factory LeaveRoomResponseProto.fromBuffer(Uint8List data) {
    final proto = $pb.LeaveRoomResponse.fromBuffer(data);
    return LeaveRoomResponseProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}

/// WebSocket消息包装器
class WebSocketMessageProto {
  final String type; // "SEND_MESSAGE", "JOIN_ROOM", "LEAVE_ROOM"
  final Uint8List payload;

  WebSocketMessageProto({
    required this.type,
    required this.payload,
  });

  factory WebSocketMessageProto.fromProto($pb.WebSocketMessage proto) {
    return WebSocketMessageProto(
      type: proto.type,
      payload: Uint8List.fromList(proto.payload),
    );
  }

  $pb.WebSocketMessage toProto() {
    return $pb.WebSocketMessage()
      ..type = type
      ..payload = payload;
  }

  factory WebSocketMessageProto.fromBuffer(Uint8List data) {
    final proto = $pb.WebSocketMessage.fromBuffer(data);
    return WebSocketMessageProto.fromProto(proto);
  }

  Uint8List toBuffer() {
    return toProto().writeToBuffer();
  }
}