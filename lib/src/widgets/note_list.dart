

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/utils/utils.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  final VoidCallback onNoteTapped;

  NoteListTile({this.note, this.onNoteTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onNoteTapped();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.title,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                '${beautifyDate(note.dateLastModified)} at ${beautifyTime(note.dateLastModified)}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            if (note.tagName.isNotEmpty)
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Text(
                      note.tagName,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
