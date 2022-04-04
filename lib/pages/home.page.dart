import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.model.dart';

import '../models/task.model.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;

  Box? _box;
  _HomePageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly!",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _tasksList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _tasksList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.formMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.timestamp.toString(),
          ),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: Colors.red,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(
              _index,
              task.toMap(),
            );
            setState(() {});
          },
          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New Task!"),
          content: TextField(
            onSubmitted: (_) {
              if (_newTaskContent != null) {
                var _task = Task(
                    content: _newTaskContent!,
                    timestamp: DateTime.now(),
                    done: false);
                _box!.add(_task.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
}



// // ignore_for_file: non_constant_identifier_names
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HomePage extends StatefulWidget {
//   HomePage();
//   @override
//   State<StatefulWidget> createState() {
//     return _HomePageSate();
//   }
// }

// class _HomePageSate extends State<HomePage> {
//   late double _deviceHeight, _deviceWidth;

//   String? _newTaskContent;

//   _HomePageSate();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: _deviceHeight * 0.1,
//         title: const Text(
//           'Taskly App',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       body: _TaskList(),
//       floatingActionButton: _addTask(),
//     );
//   }

//   Widget _tasksView() {
//     return FutureBuilder(
//       future: Hive.openBox('tasks'),
//       builder: (BuildContext _context, AsyncSnapshot _snapshot) {
//         if (_snapshot.hasData) {
//           return _TaskList();
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   Widget _TaskList() {
//     return ListView(
//       children: [
//         ListTile(
//           title: const Text(
//             "rivaldo",
//             style: TextStyle(
//               decoration: TextDecoration.lineThrough,
//             ),
//           ),
//           subtitle: Text(
//             DateTime.now().toString(),
//           ),
//           trailing: Icon(
//             Icons.check_box_outlined,
//             color: Colors.red,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _addTask() {
//     return FloatingActionButton(
//       onPressed: _displatTaskPopup,
//       child: const Icon(
//         Icons.add,
//       ),
//     );
//   }

//   void _displatTaskPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext _context) {
//         return AlertDialog(
//           title: const Text('add New Task'),
//           content: TextField(
//             onSubmitted: (value) {},
//             onChanged: (value) {
//               setState(() {
//                 _newTaskContent = value;
//               });
//             },
//           ),
//         );
//       },
//     );
//   }
// }
