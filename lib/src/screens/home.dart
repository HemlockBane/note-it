import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}
class _MyHomeScreenState extends State<MyHomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),

        ],
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.noNotes,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}

