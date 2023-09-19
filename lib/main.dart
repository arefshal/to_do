import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/util/dialog_box.dart';
import 'package:to_do/util/to_do_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _tasks = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load saved tasks from SharedPreferences
  Future<void> loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = _prefs.getStringList('tasks') ?? [];
    });
  }

  void saveTasks() {
    _prefs.setStringList('tasks', _tasks);
  }

  void addTask(String task) {
    setState(() {
      _tasks.add(task);
      _controller.clear();
      saveTasks(); // Save tasks when a new task is added
    });
  }

  void removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      saveTasks(); // Save tasks when a task is removed
    });
  }

  void toggleTaskComplete(int index, bool? newValue) {
    setState(() {
      // Implement your logic to update task completion status here
      // For example, _tasks[index].isComplete = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          'To-Do App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final taskComplete =
              false; // Replace with actual task completion status

          return ToDoTile(
            taskName: task,
            taskComplete: taskComplete,
            onChanged: (newValue) {
              // Handle checkbox changes here
              toggleTaskComplete(index, newValue);
            },
            onDelete: () {
              removeTask(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                controller: _controller,
                onCansel: () {
                  Navigator.of(context).pop();
                },
                onSave: () {
                  final task = _controller.text.trim();
                  if (task.isNotEmpty) {
                    addTask(task);
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
