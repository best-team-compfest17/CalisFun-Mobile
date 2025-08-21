import 'dart:async';
import 'dart:developer' as dev;
import 'package:calisfun/src/core/presentation/child/chatbot/chatbot_state.dart';
import 'package:calisfun/src/core/data/chat/chat_repository_impl.dart';
import 'package:calisfun/src/core/domain/chat/chat_message.dart';
import 'package:calisfun/src/core/domain/chat/chat_repository.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

// Fungsi untuk logging yang aman
void _safeLog(String message, {bool sensitive = false}) {
  // Hanya log di debug mode dan jika bukan data sensitif
  if (kDebugMode && !sensitive) {
    dev.log('[ChatBot] $message');
  }
}

// Fallback repository jika terjadi error
class EmergencyChatRepository implements ChatRepository {
  @override
  Stream<String> streamReply({
    required List<ChatMessage> context,
    required ChatMessage userMessage,
  }) async* {
    _safeLog('Using emergency chat repository');
    yield 'Maaf, layanan chatbot sedang mengalami gangguan. Silakan coba lagi nanti.';
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ref.watch(chatRepositoryImplProvider);
});

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>(
  (ref) {
    try {
      final repo = ref.watch(chatRepositoryProvider);
      return ChatController(repo);
    } catch (e) {
      _safeLog('Error initializing ChatController: ${e.runtimeType}');
      // Fallback to avoid crashing the app
      return ChatController(EmergencyChatRepository());
    }
  },
);

class ChatController extends StateNotifier<ChatState> {
  ChatController(this._repo)
    : super(
        ChatState(
          messages: [
            // Menambahkan pesan inisial dari asisten
            ChatMessage(
              id: const Uuid().v4(),
              role: ChatRole.assistant,
              content:
                  'Halo! Aku Callie, teman belajarmu di CalisFun! 😊 Aku siap membantumu belajar membaca, menulis, dan berhitung. Apa yang ingin kamu pelajari hari ini?',
              createdAt: DateTime.now(),
            ),
          ],
        ),
      );
  final ChatRepository _repo;
  StreamSubscription<String>? _sub;
  final _uuid = const Uuid();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> send(String text) async {
    final content = text.trim();
    if (content.isEmpty || state.isSending) return;

    _safeLog('Sending user message');

    final userMsg = ChatMessage(
      id: _uuid.v4(),
      role: ChatRole.user,
      content: content,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isSending: true,
      streamingBuffer: '',
    );

    _sub?.cancel();
    try {
      _safeLog('Starting stream reply');
      // Pastikan pesan user tidak duplikat dengan menghapus pesan terakhir dari konteks
      final List<ChatMessage> messagesToSend =
          state.messages.length > 1
              ? state.messages.sublist(0, state.messages.length - 1)
              : [];
      _sub = _repo
          .streamReply(context: messagesToSend, userMessage: userMsg)
          .listen(
            (chunk) {
              _safeLog('Received response chunk', sensitive: true);
              state = state.copyWith(
                streamingBuffer: state.streamingBuffer + chunk,
              );
            },
            onError: (error) {
              _safeLog('Error in stream: ${error.runtimeType}');
              // Tampilkan pesan error ke pengguna
              final errorMsg = ChatMessage(
                id: _uuid.v4(),
                role: ChatRole.assistant,
                content:
                    'Maaf, terjadi kesalahan saat memproses pesan Anda. Silakan coba lagi.',
                createdAt: DateTime.now(),
              );
              state = state.copyWith(
                messages: [...state.messages, errorMsg],
                isSending: false,
                streamingBuffer: '',
              );
            },
            onDone: () {
              _safeLog('Stream completed');
              if (state.streamingBuffer.isNotEmpty) {
                final assistantMsg = ChatMessage(
                  id: _uuid.v4(),
                  role: ChatRole.assistant,
                  content: state.streamingBuffer,
                  createdAt: DateTime.now(),
                );
                state = state.copyWith(
                  messages: [...state.messages, assistantMsg],
                  isSending: false,
                  streamingBuffer: '',
                );
              } else {
                // Jika buffer kosong tapi stream selesai, tambahkan pesan fallback
                final fallbackMsg = ChatMessage(
                  id: _uuid.v4(),
                  role: ChatRole.assistant,
                  content:
                      'Maaf, saya tidak dapat memproses pesan Anda saat ini. Silakan coba lagi nanti.',
                  createdAt: DateTime.now(),
                );
                state = state.copyWith(
                  messages: [...state.messages, fallbackMsg],
                  isSending: false,
                  streamingBuffer: '',
                );
              }
            },
          );
    } catch (e) {
      _safeLog('Exception during send: ${e.runtimeType}');
      // Handle error during stream creation
      final errorMsg = ChatMessage(
        id: _uuid.v4(),
        role: ChatRole.assistant,
        content: 'Terjadi kesalahan pada sistem. Silakan coba lagi nanti.',
        createdAt: DateTime.now(),
      );
      state = state.copyWith(
        messages: [...state.messages, errorMsg],
        isSending: false,
        streamingBuffer: '',
      );
    }
  }

  void cancel() {
    _sub?.cancel();
    state = state.copyWith(isSending: false, streamingBuffer: '');
  }

  void reset() {
    _sub?.cancel();
    state = const ChatState(messages: []);
  }
}
