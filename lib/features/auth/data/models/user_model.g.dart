// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as int?,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp?),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'gender': instance.gender,
      'date': const TimestampConverter().toJson(instance.date),
    };
