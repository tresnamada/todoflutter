
import 'package:flutter/material.dart';
import 'package:todoflutterdigiup/input_todo.dart';
import 'package:todoflutterdigiup/todo_list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tes"),
      ),
      body: Center(
        child: Container(
          child: TodoListPage(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputTodoPage()));
        },
        child: Icon(Icons.add),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}