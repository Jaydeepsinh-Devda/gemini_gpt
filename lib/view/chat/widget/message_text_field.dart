import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController userMessageController;
  final VoidCallback onSendButtonPressed;
  final bool isLoading;

  const MessageTextField({
    required this.userMessageController,
    required this.onSendButtonPressed,
    required this.isLoading,
    super.key,
  });

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return _userTextField();
  }

  //! Widget Methods
  Widget _userTextField() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: userMessageController,
          cursorColor: Colors.blue,
          decoration: _inputDecoration(),
          textInputAction: TextInputAction.newline,
        ),
      );

  InputDecoration _inputDecoration() => InputDecoration(
        hintText: "Write you message here...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: _suffix(),
        enabledBorder: _border(Colors.blueGrey),
        focusedBorder: _border(Colors.blue),
      );

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      );

  Widget _suffix() => isLoading ? _loadingIndicator() : _sendIconButton();

  Widget _sendIconButton() => IconButton(
        onPressed: onSendButtonPressed,
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.blueGrey,
        ),
      );

  Widget _loadingIndicator() => Transform.scale(
        scale: 0.6,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blueGrey,
        ),
      );
}
