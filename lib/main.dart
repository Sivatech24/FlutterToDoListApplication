import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_model.dart';
import 'package:todolist/task_provider.dart';
import 'package:todolist/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskListScreen(),
      ),
    );
  }
}
