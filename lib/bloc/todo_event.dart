part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetListTodoEvent extends TodoEvent {
  const GetListTodoEvent();

  @override
  String toString() => 'GetListTodoEvent';
}

class AddTodo extends TodoEvent {
  final String title;

  const AddTodo(this.title);

  @override
  String toString() {
    return 'AddTodoEvent $title';
  }
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent(this.id);

  @override
  String toString() {
    return 'DeleteTodoEvent $id';
  }
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String title;

  const UpdateTodoEvent(this.id, this.title);

  @override
  String toString() {
    return 'UpdateTodoEvent $id, $title';
  }
}
