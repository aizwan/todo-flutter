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
    on<AddTodo>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
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

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final int statusCode = await TodoRepository()
        .updateData(event.id, event.title, event.completed);
    if (statusCode == 200) {
      emit(TodoUpdateSuccessState());
    } else {
      emit(TodoError());
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    final int statusCode = await TodoRepository().postData(event.title);
    if (statusCode == 201) {
      emit(TodoAddSuccessState());
    } else {
      emit(TodoError());
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final int statusCode = await TodoRepository().deleteData(event.id);
    if (statusCode == 204) {
      emit(TodoDeleteSuccessState());
    } else {
      emit(TodoError());
    }
  }
}
