part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final String message;
  TaskSuccess(this.message);
}

class TaskFailure extends TaskState {
  final String error;
  TaskFailure(this.error);
}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  TaskLoaded(this.tasks);
}
