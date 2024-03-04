part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {
  @override
  String toString() => 'TodoLoadingState';
}

class TodoLoaded extends TodoState {
  final List<Todo>? todo;

  TodoLoaded({this.todo});

  TodoLoaded copyWith({
    List<Todo>? todo,
  }) {
    return TodoLoaded(
      todo: todo ?? this.todo,
    );
  }
}

class TodoEmpty extends TodoState {
  @override
  String toString() => 'TodoEmptyState';
}

class TodoError extends TodoState {
  @override
  String toString() => 'TodoErrorState';
}

class TodoAddSuccessState extends TodoState {
  @override
  String toString() => 'TodoAddSuccessState';
}

class TodoUpdateSuccessState extends TodoState {
  @override
  String toString() => 'TodoUpdateSuccessState';
}

class TodoDeleteSuccessState extends TodoState {
  @override
  String toString() => 'TodoDeleteSuccessState';
}
