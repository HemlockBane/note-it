import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';

class NoNoteInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppStrings.noNotes,
            style: Theme.of(context).textTheme.display1.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  
  }
}
