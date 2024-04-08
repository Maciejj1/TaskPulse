// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) {
  return _TaskResponse.fromJson(json);
}

/// @nodoc
mixin _$TaskResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get taskName => throw _privateConstructorUsedError;
  String? get taskDesciption => throw _privateConstructorUsedError;
  String? get taskDeadline => throw _privateConstructorUsedError;
  int? get taskPriority => throw _privateConstructorUsedError;
  int? get taskStatus => throw _privateConstructorUsedError;
  String? get owner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskResponseCopyWith<TaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskResponseCopyWith<$Res> {
  factory $TaskResponseCopyWith(
          TaskResponse value, $Res Function(TaskResponse) then) =
      _$TaskResponseCopyWithImpl<$Res, TaskResponse>;
  @useResult
  $Res call(
      {String? id,
      String? taskName,
      String? taskDesciption,
      String? taskDeadline,
      int? taskPriority,
      int? taskStatus,
      String? owner});
}

/// @nodoc
class _$TaskResponseCopyWithImpl<$Res, $Val extends TaskResponse>
    implements $TaskResponseCopyWith<$Res> {
  _$TaskResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? taskName = freezed,
    Object? taskDesciption = freezed,
    Object? taskDeadline = freezed,
    Object? taskPriority = freezed,
    Object? taskStatus = freezed,
    Object? owner = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      taskName: freezed == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskDesciption: freezed == taskDesciption
          ? _value.taskDesciption
          : taskDesciption // ignore: cast_nullable_to_non_nullable
              as String?,
      taskDeadline: freezed == taskDeadline
          ? _value.taskDeadline
          : taskDeadline // ignore: cast_nullable_to_non_nullable
              as String?,
      taskPriority: freezed == taskPriority
          ? _value.taskPriority
          : taskPriority // ignore: cast_nullable_to_non_nullable
              as int?,
      taskStatus: freezed == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskResponseImplCopyWith<$Res>
    implements $TaskResponseCopyWith<$Res> {
  factory _$$TaskResponseImplCopyWith(
          _$TaskResponseImpl value, $Res Function(_$TaskResponseImpl) then) =
      __$$TaskResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? taskName,
      String? taskDesciption,
      String? taskDeadline,
      int? taskPriority,
      int? taskStatus,
      String? owner});
}

/// @nodoc
class __$$TaskResponseImplCopyWithImpl<$Res>
    extends _$TaskResponseCopyWithImpl<$Res, _$TaskResponseImpl>
    implements _$$TaskResponseImplCopyWith<$Res> {
  __$$TaskResponseImplCopyWithImpl(
      _$TaskResponseImpl _value, $Res Function(_$TaskResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? taskName = freezed,
    Object? taskDesciption = freezed,
    Object? taskDeadline = freezed,
    Object? taskPriority = freezed,
    Object? taskStatus = freezed,
    Object? owner = freezed,
  }) {
    return _then(_$TaskResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      taskName: freezed == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskDesciption: freezed == taskDesciption
          ? _value.taskDesciption
          : taskDesciption // ignore: cast_nullable_to_non_nullable
              as String?,
      taskDeadline: freezed == taskDeadline
          ? _value.taskDeadline
          : taskDeadline // ignore: cast_nullable_to_non_nullable
              as String?,
      taskPriority: freezed == taskPriority
          ? _value.taskPriority
          : taskPriority // ignore: cast_nullable_to_non_nullable
              as int?,
      taskStatus: freezed == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskResponseImpl extends _TaskResponse {
  const _$TaskResponseImpl(
      {this.id,
      this.taskName,
      this.taskDesciption,
      this.taskDeadline,
      this.taskPriority,
      this.taskStatus,
      this.owner})
      : super._();

  factory _$TaskResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? taskName;
  @override
  final String? taskDesciption;
  @override
  final String? taskDeadline;
  @override
  final int? taskPriority;
  @override
  final int? taskStatus;
  @override
  final String? owner;

  @override
  String toString() {
    return 'TaskResponse(id: $id, taskName: $taskName, taskDesciption: $taskDesciption, taskDeadline: $taskDeadline, taskPriority: $taskPriority, taskStatus: $taskStatus, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskName, taskName) ||
                other.taskName == taskName) &&
            (identical(other.taskDesciption, taskDesciption) ||
                other.taskDesciption == taskDesciption) &&
            (identical(other.taskDeadline, taskDeadline) ||
                other.taskDeadline == taskDeadline) &&
            (identical(other.taskPriority, taskPriority) ||
                other.taskPriority == taskPriority) &&
            (identical(other.taskStatus, taskStatus) ||
                other.taskStatus == taskStatus) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, taskName, taskDesciption,
      taskDeadline, taskPriority, taskStatus, owner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskResponseImplCopyWith<_$TaskResponseImpl> get copyWith =>
      __$$TaskResponseImplCopyWithImpl<_$TaskResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskResponseImplToJson(
      this,
    );
  }
}

abstract class _TaskResponse extends TaskResponse {
  const factory _TaskResponse(
      {final String? id,
      final String? taskName,
      final String? taskDesciption,
      final String? taskDeadline,
      final int? taskPriority,
      final int? taskStatus,
      final String? owner}) = _$TaskResponseImpl;
  const _TaskResponse._() : super._();

  factory _TaskResponse.fromJson(Map<String, dynamic> json) =
      _$TaskResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get taskName;
  @override
  String? get taskDesciption;
  @override
  String? get taskDeadline;
  @override
  int? get taskPriority;
  @override
  int? get taskStatus;
  @override
  String? get owner;
  @override
  @JsonKey(ignore: true)
  _$$TaskResponseImplCopyWith<_$TaskResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
