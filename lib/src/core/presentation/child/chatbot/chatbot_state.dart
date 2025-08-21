import '../../../domain/chat/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isSending;
  final String streamingBuffer;

  const ChatState({
    required this.messages,
    this.isSending = false,
    this.streamingBuffer = '',
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    String? streamingBuffer,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      streamingBuffer: streamingBuffer ?? this.streamingBuffer,
    );
  }
}
