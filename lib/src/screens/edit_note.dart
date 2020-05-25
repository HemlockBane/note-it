import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  static final String routeName = 'edit_note';
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 8),
                  fillColor: Colors.amber,
                  isDense: true, // Makes text field compact
                ),
              ),
              Divider(),
              Row(children: <Widget>[
                Text('21 May 2020'), SizedBox(width: 30,),
                 Text('19: 49')
              ],)
              
            ],
          ),
        ),
      ),
    );
  }
}
