import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';
import '../lib/protos/chat_proto.dart';

void main() {
  group('Protobuf Message Tests', () {
    test('ChatMessageProto creation and model conversion', () {
      // 创建protobuf消息
      final originalMessage = ChatMessageProto(
        id: Int64(123456),
        roomId: Int64(789),
        senderId: Int64(456),
        content: 'Hello, World!',
        messageType: MessageType.TEXT,
        senderName: 'Test User',
        senderAvatar: 'avatar.jpg',
        timestamp: '2025-01-01T12:00:00Z',
      );

      // 验证创建正确性
      expect(originalMessage.id, Int64(123456));
      expect(originalMessage.roomId, Int64(789));
      expect(originalMessage.senderId, Int64(456));
      expect(originalMessage.content, 'Hello, World!');
      expect(originalMessage.messageType, MessageType.TEXT);
      expect(originalMessage.senderName, 'Test User');
      expect(originalMessage.senderAvatar, 'avatar.jpg');
      expect(originalMessage.timestamp, '2025-01-01T12:00:00Z');
    });

    test('SendMessageRequestProto creation', () {
      // 创建发送消息请求
      final originalRequest = SendMessageRequestProto(
        roomId: Int64(789),
        content: 'Test message content',
      );

      // 验证创建正确性
      expect(originalRequest.roomId, Int64(789));
      expect(originalRequest.content, 'Test message content');
    });

    test('ChatMessage model conversion', () {
      // 创建protobuf消息
      final protoMessage = ChatMessageProto(
        id: Int64(123456),
        roomId: Int64(789),
        senderId: Int64(456),
        content: 'Hello, World!',
        messageType: MessageType.TEXT,
        senderName: 'Test User',
        senderAvatar: 'avatar.jpg',
        timestamp: '2025-01-01T12:00:00Z',
      );

      // 转换为模型
      final modelMessage = protoMessage.toModel(currentUserId: '456');

      // 验证转换正确性
      expect(modelMessage.id, '123456');
      expect(modelMessage.roomId, '789');
      expect(modelMessage.senderId, '456');
      expect(modelMessage.content, 'Hello, World!');
      expect(modelMessage.messageType, 'TEXT');
      expect(modelMessage.senderName, 'Test User');
      expect(modelMessage.senderAvatar, 'avatar.jpg');
      expect(modelMessage.isSentByUser, true);
    });

    test('MessageType string conversion', () {
      final message = ChatMessageProto(
        id: Int64(1),
        roomId: Int64(1),
        senderId: Int64(1),
        content: 'Test',
        messageType: MessageType.TEXT,
        senderName: 'Test',
        senderAvatar: '',
        timestamp: '2025-01-01T12:00:00Z',
      );
      
      // 通过实例方法测试转换
      final model = message.toModel();
      expect(model.messageType, 'TEXT');
    });

    test('ChatResponseProto creation', () {
      // 创建聊天消息
      final chatMessage = ChatMessageProto(
        id: Int64(123),
        roomId: Int64(789),
        senderId: Int64(456),
        content: 'Test message',
        messageType: MessageType.TEXT,
        senderName: 'Test User',
        senderAvatar: 'avatar.jpg',
        timestamp: '2025-01-01T12:00:00Z',
      );

      // 创建响应
      final originalResponse = ChatResponseProto(
        success: true,
        errorMessage: '',
        payload: chatMessage,
      );

      // 验证创建正确性
      expect(originalResponse.success, true);
      expect(originalResponse.errorMessage, '');
      expect(originalResponse.payload is ChatMessageProto, true);
    });
  });
}