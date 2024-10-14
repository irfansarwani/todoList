import 'package:flutter/material.dart';
import 'package:todo_app/utils/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final List _todoList = [
    ["Code with Irfan", false],
    ["Learn Flutter", false],
    ["Learn Dart", true],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      _todoList[index][1] = !_todoList[index][1];
    });
  }

  void deleteTask(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoList.add([_controller.text, false]);
        _controller.clear();
      });
    }
  }

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter task name',
              filled: true,
              fillColor: Colors.deepPurple[100],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                saveNewTask();
                Navigator.of(context)
                    .pop(); // Only call pop after adding the task.
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do App by Irfan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 169, 139, 250),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (BuildContext context, index) {
                return TodoList(
                  taskName: _todoList[index][0],
                  taskCompleted: _todoList[index][1],
                  onChange: (value) => checkBoxChanged(index),
                  deleteFunction: (value) => deleteTask(index),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Coded by Irfan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
