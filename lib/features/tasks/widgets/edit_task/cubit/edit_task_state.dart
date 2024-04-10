part of 'edit_task_cubit.dart';

@freezed
class EditTaskState with _$EditTaskState {
  const factory EditTaskState.initial() = _Initial;
  const factory EditTaskState.loading() = _Loading;
  const factory EditTaskState.success(List<User> users) = _Success;
  const factory EditTaskState.error(String message) = _Error;
}
