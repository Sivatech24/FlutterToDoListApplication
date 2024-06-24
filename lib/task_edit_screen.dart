import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_model.dart';
import 'package:todolist/task_provider.dart';
import 'package:uuid/uuid.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;

  TaskEditScreen({this.task});

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _category;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _category = widget.task!.category;
      _isCompleted = widget.task!.isCompleted;
    } else {
      _title = '';
      _description = '';
      _category = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) {
                  _category = value!;
                },
              ),
              CheckboxListTile(
                title: Text('Completed'),
                value: _isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    _isCompleted = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Task newTask = Task(
                      id: widget.task?.id ?? Uuid().v4(),
                      title: _title,
                      description: _description,
                      category: _category,
                      isCompleted: _isCompleted,
                    );
                    if (widget.task == null) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                    } else {
                      Provider.of<TaskProvider>(context, listen: false).updateTask(newTask);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
