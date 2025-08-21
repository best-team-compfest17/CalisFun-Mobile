import 'package:calisfun/src/core/presentation/child/chatbot/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/domain/chat/chat_message.dart';
import 'package:calisfun/src/widgets/widgets.dart';

class ChatbotPage extends ConsumerStatefulWidget {
  const ChatbotPage({super.key});

  @override
  ConsumerState<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends ConsumerState<ChatbotPage> {
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });

    final items = [
      ...state.messages,
      if (state.streamingBuffer.isNotEmpty)
        ChatMessage(
          id: 'stream',
          role: ChatRole.assistant,
          content: state.streamingBuffer,
          createdAt: DateTime.now(),
        ),
    ];

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Row(
              children: [
                const AppPrevButton(),
                SizedBox(width: 22.w),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundImage: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                      ),
                    ),
                    Gap.w12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Callie', style: TypographyApp.headingSmallBold),
                        Gap.h4,
                        Text(
                          'Teman Belajarmu',
                          style: TypographyApp.labelSmallMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Gap.h16,
            Expanded(
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: EdgeInsets.only(bottom: SizeApp.h12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final m = items[index];
                  final isUser = m.role == ChatRole.user;
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: SizeApp.h5),
                      padding: EdgeInsets.all(SizeApp.h12),
                      constraints: BoxConstraints(maxWidth: 640.w),
                      decoration: BoxDecoration(
                        color:
                            isUser
                                ? ColorApp.primary.withOpacity(0.1)
                                : ColorApp.greyInactive,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        m.content,
                        style: TypographyApp.labelSmallMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Masukkan pertanyaanmu di sini',
                    controller: _textCtrl,
                    keyboardType: TextInputType.text,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16,
                      vertical: SizeApp.h12,
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                  ),
                ),
                SizedBox(width: SizeApp.w8),
                Container(
                  width: SizeApp.w48,
                  height: SizeApp.h48,
                  decoration: BoxDecoration(
                    color: ColorApp.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap:
                          state.isSending
                              ? controller.cancel
                              : () => _onSend(controller),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Icon(
                          state.isSending
                              ? Icons.stop_circle_outlined
                              : Icons.send_rounded,
                          color: ColorApp.mainWhite,
                          size: SizeApp.w24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h16,
          ],
        ),
      ),
    );
  }

  void _onSend(ChatController controller) {
    final text = _textCtrl.text;
    _textCtrl.clear();
    controller.send(text);
  }
}
