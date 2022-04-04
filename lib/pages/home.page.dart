// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageSate();
  }
}

class _HomePageSate extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  _HomePageSate();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.1,
        title: const Text(
          'Taskly App',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: _TaskList(),
      floatingActionButton: _addTadst(),
    );
  }

  Widget _TaskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "rivaldo",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            DateTime.now().toString(),
          ),
          trailing: Icon(
            Icons.check_box_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _addTadst() {
    return FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ));
  }
}
