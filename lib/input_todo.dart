import 'package:flutter/material.dart';
import 'package:todoflutterdigiup/todo_repository.dart';
import 'todo_model.dart'; // Adjust the path as necessary
import 'package:intl/intl.dart'; // Import the intl package

class InputTodoPage extends StatefulWidget {
  
  final Todo? todo;

  InputTodoPage({this.todo});
  
  @override
  _InputTodoPageState createState() => _InputTodoPageState();
}


class _InputTodoPageState extends State<InputTodoPage> {
  TodoRepository repository = TodoRepository();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController attachmentsController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  // untuk prioritas yang dipilih
  String? priority;
  String? status;
  


  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      dueDateController.text = widget.todo!.dueDate;
      priority = widget.todo!.priority;
      status = widget.todo!.status;
    }
  }

  void saveTodo() {
    final title = titleController.text;
    final description = descriptionController.text;
    final dueDate = dueDateController.text;
    final statusValue = status;
    final priorityValue = priority; // Get the selected priority value
    if (title.isNotEmpty) {
      final todo = Todo(
        id: widget.todo?.id ?? DateTime.now().toString(),
        title: title,
        description: description,
        priority: priorityValue ?? 'LOW',
        dueDate: dueDate,
        status: statusValue ?? 'Initial',
      );
      if (widget.todo != null) {
        repository.addTodo(todo);
      } else {
        repository.updateTodo(todo);
      }
      setState(() {}); // Update UI after saving
      Navigator.of(context).pop(); // Return to previous page
    }
  }

  

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // Format the date to dd-MM-yyyy
        dueDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Todo')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              minLines: 2,
              maxLines: 4,
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButtonFormField<String>(
              value: priority,
              onChanged: (String? newValue) {
                setState(() {
                  priority = newValue;
                });
              },
              decoration: InputDecoration(labelText: 'Priority'),
              items: ['IMPORTANT', 'MEDIUM', 'LOW']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select Priority'),
            ),
            // Date Picker for Due Date
            GestureDetector(
              onTap: () => _selectDueDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dueDateController,
                  decoration: InputDecoration(labelText: 'Due Date'),
                ),
              ),
            ),
            // Radio Buttons for Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                      value: 'Initial',
                      groupValue: status,
                      onChanged: (String? value) {
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                    Text('Initial'),
                    Radio<String>(
                      value: 'On Progress',
                      groupValue: status,
                      onChanged: (String? value) {
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                    Text('On Progress'),
                    Radio<String>(
                      value: 'Completed',
                      groupValue: status,
                      onChanged: (String? value) {
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                    Text('Completed'),
                  ],
                ),
                 TextField(
                  
                  decoration: InputDecoration(labelText: 'Notes'),
                 )
                 ,
                ElevatedButton(
                  onPressed: saveTodo,
                  child: Text('Save'),
                ),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Return to previous page
                  },
                  child: Text('Cancel'),
                ),
              ],
              
            ),
            
          ]
          ),
          
        ));
  }
}
