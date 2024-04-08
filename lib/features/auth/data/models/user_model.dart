import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    final String? id,
    final String? email,
    final String? password,
    final String? name,
    final int? gender,
    final DateTime? date,
  }) = _User;

  const User._();
  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
