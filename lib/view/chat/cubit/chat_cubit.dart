import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_with_gemini_ai/view/chat/cubit/chat_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  FutureOr<void> chatWithGemini(String prompt) async {
    emit(ChatLoadingState());
    try {
      final model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: dotenv.env["GOOGLE_API_KEY"] ?? "");

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      emit(ChatSuccessState(text: response.text ?? ""));
    } catch (e) {
      emit(ChatFailureState(errMessage: e.toString()));
    }
  }
}
