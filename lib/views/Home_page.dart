import 'package:crud_api/controller/todo_controller.dart';
import 'package:crud_api/models/todo.dart';
import 'package:crud_api/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // INJETANDO DEPENDENCIA
  final _todoController = TodoController(TodoRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoController.fetchTodoList(),
        builder: (context, snapshot) {
          //
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          return buildBodyContent(snapshot);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //nake post call
          // temp data
          Todo todo = Todo(userId: 3, title: "simple post", completed: false);
          _todoController.postTodo(todo);
        },
      ),
    );
  }

  SafeArea buildBodyContent(AsyncSnapshot<List<Todo>> snapshot) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var _todo = snapshot.data?[index];
            return Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text("${_todo?.id}")),
                  Expanded(flex: 3, child: Text("${_todo?.title}")),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                //ADD METODO
                                _todoController.updatePatchCompleted(_todo!);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(microseconds: 500),
                                  content: Text('Update'),
                                ));
                              },
                              child: builderCallContainer(
                                  "patch", Color(0xFFFFA726))),
                          InkWell(
                              onTap: () {
                                _todoController.updatePutCompleted(_todo!);
                              },
                              child: builderCallContainer(
                                  "put", Color(0xFF6A1B9A))),
                          InkWell(
                              onTap: () {
                                _todoController.deleteTodo(_todo!);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(microseconds: 500),
                                  content: Text('Update'),
                                ));
                              },
                              child: builderCallContainer(
                                  "del", Color(0xFFC62828))),
                        ],
                      )),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container builderCallContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text("${title}")),
    );
  }
}
