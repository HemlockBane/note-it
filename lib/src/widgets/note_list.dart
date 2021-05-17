import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/utils/utils.dart';
import 'package:note_it/src/widgets/theme.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.red, width: 5.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.title,
                style: bodyText1Style(
                  context,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: bodyText1Style(context, fontSize: 14),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                '${beautifyDate(note.dateLastModified)} at ${beautifyTime(note.dateLastModified)}',
                style: bodyText1Style(context, fontSize: 12, color: AppTheme.grey, fontWeight: FontWeight.w500),
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
