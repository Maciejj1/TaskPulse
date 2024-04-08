// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskResponseImpl _$$TaskResponseImplFromJson(Map<String, dynamic> json) =>
    _$TaskResponseImpl(
      id: json['id'] as String?,
      taskName: json['taskName'] as String?,
      taskDesciption: json['taskDesciption'] as String?,
      taskDeadline: json['taskDeadline'] as String?,
      taskPriority: json['taskPriority'] as int?,
      taskStatus: json['taskStatus'] as int?,
      owner: json['owner'] as String?,
    );

Map<String, dynamic> _$$TaskResponseImplToJson(_$TaskResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskName': instance.taskName,
      'taskDesciption': instance.taskDesciption,
      'taskDeadline': instance.taskDeadline,
      'taskPriority': instance.taskPriority,
      'taskStatus': instance.taskStatus,
      'owner': instance.owner,
    };
