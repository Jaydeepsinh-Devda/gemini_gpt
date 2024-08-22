import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    required this.message,
    required this.isUser,
    super.key,
  });

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return _chatList();
  }

  //! Widget Methods
  Widget _chatList() => ListTile(
        title: Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: _container(),
        ),
      );

  Widget _container() => Container(
        padding: const EdgeInsets.all(10),
        decoration: _chatDecoration(),
        child: _chatMessage(),
      );

  Widget _chatMessage() => Text(
        message,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black,
        ),
      );

  BoxDecoration _chatDecoration() => BoxDecoration(
        color: isUser ? Colors.blue : Colors.grey[300],
        borderRadius: isUser ? _usersBorderRadius() : _aiBorderRadius(),
      );

  BorderRadius _usersBorderRadius() => const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );

  BorderRadius _aiBorderRadius() => const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );
}
