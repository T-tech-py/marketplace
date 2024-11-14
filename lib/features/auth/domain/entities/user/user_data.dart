// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  @JsonSerializable(explicitToJson: true)
  const factory UserData({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatar,
    required int id,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
