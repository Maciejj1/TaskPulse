import 'package:cloud_firestore/cloud_firestore.dart';
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
    @TimestampConverter() final DateTime? date, // Use a custom converter for Timestamp
  }) = _User;

  const User._();
  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Custom converter for Timestamp
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }
}
