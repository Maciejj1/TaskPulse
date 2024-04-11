part of 'task_cubit_cubit.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;
  const factory TaskState.loading() = _Loading;
  const factory TaskState.success(TaskResponse tasks) = _Success;
  const factory TaskState.error(String message) = _Error;
}
