import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Bloc _todoBloc = TodoBloc();
  var todoLists = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _todoBloc.add(GetListTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: todoBackground,
      body: Stack(
        children: [
          BlocListener(
            bloc: _todoBloc,
            listener: (context, state) {
              if (state is TodoAddSuccessState ||
                  state is TodoUpdateSuccessState ||
                  state is TodoDeleteSuccessState) {
                _todoBloc.add(GetListTodoEvent());
              }
              if (state is TodoError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Something wrong!'),
                ));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            "Todo List",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        BlocBuilder(
                          bloc: _todoBloc,
                          builder: (context, state) {
                            if (state is TodoLoaded) {
                              return Column(
                                children: [..._generateTodoItems(state.todo!)],
                              );
                            } else if (state is TodoEmpty) {
                              return Center(
                                child: Text('List empty.'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: "Add new todo item",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: todoPurple,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    todo.isDone = !todo.isDone;
    _todoBloc.add(UpdateTodoEvent(todo.id!, todo.todoText!, todo.isDone));
  }

  void _deleteTodoItem(String id) {
    _todoBloc.add(DeleteTodoEvent(id));
  }

  List<Widget> _generateTodoItems(List<Todo>? todos) {
    List<Widget> list = [];
    for (Todo todo in todos!) {
      list.add(TodoItem(
        todo: todo,
        onTodoChange: _handleTodoChange,
        onDeleteItem: _deleteTodoItem,
      ));
    }
    return list;
  }

  void _addTodoItem(String todo) {
    setState(() {
      if (todo != '') {
        _todoBloc.add(AddTodo(todo));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter an item'),
        ));
      }
    });
    _todoController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
