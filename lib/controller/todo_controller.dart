import 'package:crud_api/models/todo.dart';
import 'package:crud_api/repository/repository.dart';

import 'package:crud_api/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  //GET
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  //UPDATE
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  //PUT
  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  //DELETE
  Future<String> deleteTodo(Todo todo) async {
    return _repository.deleteCompleted(todo);
  }

  Future<String> postTodo(Todo todo) async {
    return _repository.postCompleted(todo);
  }
}
