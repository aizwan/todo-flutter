import 'package:dio/dio.dart';
import 'package:todo/model/todo.dart';
import '../configuration.dart' as config;

class TodoRepository {
  final Dio _dio = Dio();
  final String baseURL = config.BASE_URL;

  Future<List<Todo>> getTodoList() async {
    try {
      var response = await _dio.get("$baseURL/api/todo");

      Iterable list = response.data['data'];

      return list.map((model) => Todo.fromJson(model)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> postData(String title) async {
    try {
      Response response = await _dio.post(
        '$baseURL/api/todo',
        data: {"title": title},
      );

      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var data = {"data": null};
      return data;
    }
  }

  Future<dynamic> deleteData(String id) async {
    try {
      Response response = await _dio.delete('$baseURL/api/todo/$id');

      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var data = {"data": null};
      return data;
    }
  }

  Future<dynamic> updateData(String id, String title) async {
    try {
      Response response = await _dio.patch(
        '$baseURL/api/todo/$id',
        data: {"title": title},
      );

      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var data = {"data": null};
      return data;
    }
  }
}
