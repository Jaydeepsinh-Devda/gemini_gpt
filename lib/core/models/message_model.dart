import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
    const factory MessageModel({
        String? message,
        required bool isUser,
    }) = _MessageModel;

    factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
