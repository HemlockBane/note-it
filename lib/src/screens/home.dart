import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _currentTabIndex = 0;

  void _changeTab(int nextTabIndex) {
    setState(() {
      _currentTabIndex = nextTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: Drawer(),
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentTabIndex,
//        selectedItemColor: Colors.black,
//        unselectedItemColor: Colors.grey,
//        onTap: (newTabIndex){
//          _changeTab(newTabIndex);
//        },
//        //type: BottomNavigationBarType.shifting,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.book),
//            title: Text('Notes'),
//            backgroundColor: Colors.black
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.star),
//            title: Text('Favourites'),
//            backgroundColor: Colors.blue
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.label),
//            title: Text('Tags')
//          ),
//        ]
//      ),

      bottomNavigationBar: BottomAppBar(
        color: ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.noNotes,
              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}
