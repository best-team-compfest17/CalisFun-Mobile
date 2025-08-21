import 'dart:async';
import 'chat_message.dart';

abstract class ChatRepository {
  Stream<String> streamReply({
    required List<ChatMessage> context,
    required ChatMessage userMessage,
  });
}
