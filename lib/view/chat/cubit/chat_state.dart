import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatFailureState extends ChatState {
  final String errMessage;

  const ChatFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class ChatSuccessState extends ChatState {
  final String text;

  const ChatSuccessState({required this.text});

  @override
  List<Object?> get props => [text];
}
