import 'package:chat_app_with_gemini_ai/core/models/message_model.dart';
import 'package:chat_app_with_gemini_ai/view/chat/cubit/chat_cubit.dart';
import 'package:chat_app_with_gemini_ai/view/chat/cubit/chat_state.dart';
import 'package:chat_app_with_gemini_ai/view/chat/widget/chat_bubble.dart';
import 'package:chat_app_with_gemini_ai/view/chat/widget/message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit _chatCubit;

  final List<MessageModel> _messages = [];

  final TextEditingController _userMessageController = TextEditingController();

  //! Widget Lifecycle Method
  @override
  void initState() {
    _chatCubit = context.read<ChatCubit>();
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return _blocConsumer();
  }

  //! Widget Methods
  Widget _blocConsumer() => BlocConsumer<ChatCubit, ChatState>(
        builder: _builder,
        listener: _listener,
      );

  Widget _builder(BuildContext context, ChatState state) {
    if (state is ChatSuccessState) {
      _messages.add(MessageModel(isUser: false, message: state.text));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _scaffoldBody(state),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        title: const Text(
          "Gemini GPT",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      );

  Widget _scaffoldBody(ChatState state) => SafeArea(
        child: _column(state),
      );

  Widget _column(ChatState state) => Column(
        children: [
          _listBuilder(),
          _userTextField(state),
        ],
      );

  Widget _listBuilder() => Expanded(
        child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) => _chatBubble(index),
        ),
      );

  Widget _chatBubble(int index) => ChatBubble(
        message: _messages[index].message ?? "",
        isUser: _messages[index].isUser,
      );

  Widget _userTextField(ChatState state) => MessageTextField(
        userMessageController: _userMessageController,
        onSendButtonPressed: _onSendButtonPressed,
        isLoading: state is ChatLoadingState,
      );

  //! Listener
  void _listener(BuildContext context, ChatState state) {
    if (state is ChatFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //! Function
  void _onSendButtonPressed() {
    if (_userMessageController.text.trim().isNotEmpty) {
      _messages.add(
          MessageModel(isUser: true, message: _userMessageController.text));
      _chatCubit.chatWithGemini(_userMessageController.text);
      _userMessageController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
