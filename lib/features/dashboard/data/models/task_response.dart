import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_response.freezed.dart';
part 'task_response.g.dart';

@freezed
class TaskResponse with _$TaskResponse {
  const factory TaskResponse({
    final String? id,
    final String? taskName,
    final String? taskDesciption,
    final String? taskDeadline,
    final int? taskPriority,
    final int? taskStatus,
    final String? owner,
  }) = _TaskResponse;

  const TaskResponse._();

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);
  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskDesciption": taskDesciption,
        "taskDeadline": taskDeadline,
        "taskPriority": taskPriority,
        "owner": owner
      };
}
