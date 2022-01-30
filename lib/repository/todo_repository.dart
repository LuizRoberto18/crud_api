import 'package:crud_api/models/todo.dart';
import 'package:crud_api/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  //CHAMANDO API
  String dataURL = "https://jsonplaceholder.typicode.com";

  @override
  Future<String> deleteCompleted(Todo todo) async {
    var url = Uri.parse("${dataURL}/todos/${todo.id}");
    var result = "false";
    await http.delete(url).then((value) {
      print(value.body);
      //TEMp
      return result = "true";
    });
    return result;
  }

// PEGA TODA LISTA
  @override
  Future<List<Todo>> getTodoList() async {
    //LISTA DE TODOS
    List<Todo> todoList = [];
    //CHAMANDO URL COM OS DADOS DE TODOS
    //https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse("${dataURL}/todos");
    //OBTENDO DADOS DA URL COMO RESPOSTA
    var response = await http.get(url);
    //MOSTRANDO STATUS DA RESPOSTA NO CONSOLE
    print("status code: ${response.statusCode}");
    //PEGANDOO CORPO DA RESPOSTA DA URL NO FORMATO JSON
    var body = json.decode(response.body);
    //PERCORRENDO O CORPO DA URL PARA MOSTRAR AS INFORMAÇÕES DOS TODOS
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[1]));
    }
    // RETORNANDO A LISTA
    return todoList;
  }

// PATCH
//PATCH -> MODIFY PASSED VARIABLES ONLY
  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse("${dataURL}/todos/${todo.id}");
    //CALL BACK DATA
    String resData = "";
    //BOOL? -> STRING
    await http.patch(
      url,
      body: {
        "completed": (!todo.completed!).toString(),
      },
      headers: {"Authorization": "your_token"},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result["completed"];
      //NAKE CALL
    });
    return resData;
  }

// MODIFY PASSED VARIABLES ONLY AND TREAT OTHER VARIABLES NULL OR DEFAULT
  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse("${dataURL}/todos/${todo.id}");
    //CALL BACK DATA
    String resData = "";
    //BOOL? -> STRING
    await http.put(
      url,
      body: {
        "completed": (!todo.completed!).toString(),
      },
      headers: {"Authorization": "your_token"},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result["completed"];
      //NAKE CALL
    });
    return resData;
  }

  @override
  Future<String> postCompleted(Todo todo) async {
    print("${todo.toJson()}");
    var url = Uri.parse("${dataURL}/todos/");
    var result = "";

    var response = await http.post(url, body: todo.toJson());
    // FAKE SERVER => GET RETURN TYPE != POST TYPE
    //CHANCE TOJSON METODO
    print(response.statusCode);
    print(response.body);
    return "true";
  }
}
