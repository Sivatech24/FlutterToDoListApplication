import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_model.dart';
import 'package:todolist/task_provider.dart';
import 'package:todolist/task_edit_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskProvider.deleteTask(task.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditScreen(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditScreen(),
            ),
          );
        },
      ),
    );
  }
}
