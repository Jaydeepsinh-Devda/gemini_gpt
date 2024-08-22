import 'package:chat_app_with_gemini_ai/view/chat/cubit/chat_cubit.dart';
import 'package:chat_app_with_gemini_ai/view/chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider<ChatCubit>(
        create: (context) => ChatCubit(),
        child: const ChatScreen(),
      ),
    );
  }
}
