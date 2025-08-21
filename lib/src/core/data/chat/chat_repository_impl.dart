import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:calisfun/src/core/domain/chat/chat_message.dart';
import 'package:calisfun/src/core/domain/chat/chat_repository.dart';
import 'package:calisfun/src/network/endpoint.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Fungsi untuk logging yang aman
void _safeLog(String message, {bool sensitive = false}) {
  // Hanya log di debug mode dan jika bukan data sensitif
  if (kDebugMode && !sensitive) {
    dev.log('[ChatRepo] $message');
  }
}

final chatRepositoryImplProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl();
});

class ChatRepositoryImpl implements ChatRepository {
  @override
  Stream<String> streamReply({
    required List<ChatMessage> context,
    required ChatMessage userMessage,
  }) async* {
    final uri = Endpoint.chatUri();
    final isAzure = Endpoint.chatMode == ChatMode.directAzure;

    final messages = [
      {
        'role': 'system',
        'content':
            'Kamu adalah asisten Callie dari aplikasi CalisFun, aplikasi belajar '
            'untuk anak-anak. Kamu membantu anak-anak belajar membaca, menulis, '
            'dan berhitung. Berikan jawaban yang ramah, sederhana, dan mudah '
            'dipahami untuk anak-anak. Hindari jawaban yang terlalu panjang '
            'atau rumit. Gunakan emoji 😊 untuk membuat jawabanmu lebih menyenangkan.',
      },
      ...context.map(
        (m) => {
          'role': m.role == ChatRole.user ? 'user' : 'assistant',
          'content': m.content,
        },
      ),
      {'role': 'user', 'content': userMessage.content},
    ];

    final headers = {'Content-Type': 'application/json'};

    if (isAzure) {
      headers['api-key'] = Endpoint.azureApiKey;
    }

    final body =
        isAzure
            ? jsonEncode({
              'messages': messages,
              'temperature': 0.7,
              'max_tokens': 800,
              'stream': true,
            })
            : jsonEncode({
              'message': userMessage.content,
              'context':
                  context
                      .map(
                        (m) => {
                          'role':
                              m.role == ChatRole.user ? 'user' : 'assistant',
                          'content': m.content,
                        },
                      )
                      .toList(),
              'system_message':
                  'Kamu adalah asisten Callie dari aplikasi CalisFun, aplikasi belajar '
                  'untuk anak-anak. Kamu membantu anak-anak belajar membaca, menulis, '
                  'dan berhitung. Berikan jawaban yang ramah, sederhana, dan mudah '
                  'dipahami untuk anak-anak. Hindari jawaban yang terlalu panjang '
                  'atau rumit. Gunakan emoji 😊 untuk membuat jawabanmu lebih menyenangkan. '
                  'Namamu adalah Callie, selalu perkenalkan diri sebagai Callie, teman belajar anak-anak.',
              'options': {'temperature': 0.7, 'max_tokens': 800},
            });

    try {
      // Log request details for debugging (tanpa data sensitif)
      _safeLog('Sending chat request to: ${uri.toString().split('?')[0]}');

      final request = http.Request('POST', uri);
      request.headers.addAll(headers);
      request.body = body;

      final response = await http.Client().send(request);
      _safeLog('Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        final errorBody = await response.stream.bytesToString();
        _safeLog('Error with status code: ${response.statusCode}');
        throw Exception('Error: ${response.statusCode}');
      }

      // Proses streaming response
      _safeLog('Starting to process streaming response');
      await for (final chunk in response.stream.transform(utf8.decoder)) {
        if (chunk.isEmpty) continue;

        _safeLog('Received response chunk', sensitive: true);

        // Parsing respons berbeda antara Azure dan proxy backend
        if (isAzure) {
          // Format Azure: data: {JSON}\n\n
          final lines = chunk.split('\n');
          for (final line in lines) {
            if (line.startsWith('data: ') && line != 'data: [DONE]') {
              try {
                final jsonStr = line.substring(6); // remove 'data: '
                _safeLog('Parsing Azure response');
                final jsonData = jsonDecode(jsonStr);
                final content =
                    jsonData['choices'][0]['delta']['content'] as String?;
                if (content != null && content.isNotEmpty) {
                  yield content;
                }
              } catch (e) {
                _safeLog('Error parsing response: ${e.runtimeType}');
                // Try to yield the raw text after "data: " as fallback
                if (line.length > 6) {
                  final content = line.substring(6);
                  if (content.isNotEmpty) {
                    yield content;
                  }
                }
              }
            }
          }
        } else {
          // Format proxy backend (Tergantung implementasi backend)
          _safeLog('Processing proxy backend response');
          try {
            final jsonData = jsonDecode(chunk);

            // Cek beberapa format respons yang mungkin dari backend
            String? content;

            // Prioritaskan format yang muncul pada log: format respons memiliki field "reply"
            if (jsonData.containsKey('reply')) {
              content = jsonData['reply'] as String?;
            } else if (jsonData.containsKey('content')) {
              content = jsonData['content'] as String?;
            } else if (jsonData.containsKey('message')) {
              content = jsonData['message'] as String?;
            } else if (jsonData.containsKey('text')) {
              content = jsonData['text'] as String?;
            } else if (jsonData.containsKey('response')) {
              content = jsonData['response'] as String?;
            } else if (jsonData.containsKey('answer')) {
              content = jsonData['answer'] as String?;
            } else if (jsonData.containsKey('data') &&
                jsonData['data'] is Map) {
              final data = jsonData['data'] as Map;
              if (data.containsKey('content')) {
                content = data['content'] as String?;
              } else if (data.containsKey('text')) {
                content = data['text'] as String?;
              } else if (data.containsKey('message')) {
                content = data['message'] as String?;
              }
            } else if (jsonData.containsKey('choices') &&
                jsonData['choices'] is List &&
                (jsonData['choices'] as List).isNotEmpty) {
              final choice = (jsonData['choices'] as List).first;
              if (choice is Map) {
                if (choice.containsKey('message')) {
                  final message = choice['message'];
                  if (message is Map && message.containsKey('content')) {
                    content = message['content'] as String?;
                  }
                } else if (choice.containsKey('text')) {
                  content = choice['text'] as String?;
                }
              }
            }

            if (content != null && content.isNotEmpty) {
              yield content;
            } else {
              _safeLog('Content format not recognized');
              // Jika semua cara di atas gagal, coba kirim pesan yang lebih aman
              yield "Maaf, saya tidak dapat memproses pesan Anda saat ini.";
            }
          } catch (e) {
            _safeLog('Error parsing response: ${e.runtimeType}');
            // Kirim pesan yang lebih aman tanpa detil error
            yield "Maaf, saya tidak dapat memahami respons saat ini.";
          }
        }
      }
    } catch (e) {
      _safeLog('Error streaming chat: ${e.runtimeType}');
      // Coba kirim pesan error ke UI sebagai fallback, tanpa menampilkan detail error spesifik
      yield 'Maaf, ada kesalahan saat berkomunikasi. Silakan coba lagi nanti.';
      throw Exception('Failed to stream chat');
    }
  }
}
