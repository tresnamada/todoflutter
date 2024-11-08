import 'package:hive/hive.dart';
import 'todo_model.dart';

class TodoRepository {
  static const String _boxName = 'todos';

  Future<Box<Todo>> _getBox() async {
    return await Hive.openBox<Todo>(_boxName);
  }

  // Create
  Future<void> addTodo(Todo todo) async {
    final box = await _getBox();
    await box.put(todo.id, todo);
  }

  // Read
  Future<List<Todo>> getTodos() async {
    final box = await _getBox();
    return box.values.toList();
  }

  // Update
  Future<void> updateTodo(Todo todo) async {
    final box = await _getBox();
    await box.put(todo.id, todo);
  }

  // Delete
  Future<void> deleteTodo(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }
}
