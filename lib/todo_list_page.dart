import 'package:flutter/material.dart';
import 'package:todoflutterdigiup/input_todo.dart';
import 'todo_repository.dart';
import 'todo_model.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoRepository _repository = TodoRepository();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _repository.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _deleteTodo(Todo todo) async {
    // Confirm delete action
    final bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel delete
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm delete
              },
            ),
          ],
        );
      },
    );

    // If the user confirmed, delete the todo
    if (shouldDelete == true) {
      await _repository.deleteTodo(todo.id);  // Perform deletion
      _loadTodos(); // Reload todos after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'List Todo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16), // Space between title and list
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.description),
                      Text('Prioritas : ${todo.priority}'),
                      Text('Due Date : ${todo.dueDate}'),
                    ],),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to InputTodoPage for editing
                          // Navigator.push(
                          //   context,
                            MaterialPageRoute(
                              builder: (context) => InputTodoPage(todo: todo), // Pass the todo to the edit page
                            );
                          // ).then((_) {
                          //   // Reload todos after returning from InputTodoPage
                          //   _loadTodos();
                          // });
                        },
                      ),
                      // Delete Button
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                         _deleteTodo(todo);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
