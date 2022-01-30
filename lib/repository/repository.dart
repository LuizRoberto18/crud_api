// fake repostory
import 'package:crud_api/models/todo.dart';

abstract class Repository {
  //GET
  Future<List<Todo>> getTodoList();
  //PATCH
  Future<String> patchCompleted(Todo todo);
  //PUT
  Future<String> putCompleted(Todo todo);
  //DELETE
  Future<String> deleteCompleted(Todo todo);
  //POST
  Future<String> postCompleted(Todo todo);
}
