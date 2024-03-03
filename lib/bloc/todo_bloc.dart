import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      //initial state
      emit(TodoLoading());
    });

    on<GetListTodoEvent>(_onGetListTodo);
  }

  Future<void> _onGetListTodo(
      GetListTodoEvent event, Emitter<TodoState> emit) async {
    final List<Todo> todo = await TodoRepository().getTodoList();
    if (todo.length > 0) {
      emit(TodoLoaded(todo: todo));
    } else {
      emit(TodoEmpty());
    }
  }
}
