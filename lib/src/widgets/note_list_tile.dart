import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/models/slidable_menu_options.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/utils/utils.dart';
import 'package:note_it/src/widgets/theme.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  final VoidCallback onNoteTapped;
  NoteNotifier _noteNotifier;

  NoteListTile({this.note, this.onNoteTapped});

  @override
  Widget build(BuildContext context) {
    _noteNotifier = NoteNotifier.of(context);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [
        ...getSlidableMenuOptionsForNote(note)
            .map(
              (option) => IconSlideAction(
                caption: option.label,
                icon: option.iconData,
                onTap: () {
                  _onMenuOptionSelected(option.value, note);
                },
              ),
            )
            .toList(),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9.0),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.surface,
          border: Border(
            left: BorderSide(color: Colors.red, width: 5.0),
          ),
        ),
        child: Container(
          width: double.infinity,
          // For some reason, without this property, one action hides behind the listtile
          child: listTile(context),
        ),
      ),
    );
  }

  Widget listTile(BuildContext context) {
    return InkWell(
      onTap: () {
        onNoteTapped();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              note.title,
              style: bodyText1Style(
                context,
                color: Theme.of(context).colorScheme.onPrimary,
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
              style: bodyText1Style(
                context,
                fontSize: 14,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              '${beautifyDate(note.dateLastModified)} at ${beautifyTime(note.dateLastModified)}',
              style: bodyText1Style(
                context,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (note.tagName.isNotEmpty)
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Text(
                    note.tagName,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }

  void _onMenuOptionSelected(SlidableMenuValue value, Note note) async {
    switch (value) {
      case SlidableMenuValue.soft_delete:
        await _noteNotifier.editNote(note.copyWith(isSoftDeleted: true));

        break;
      case SlidableMenuValue.restore:
        await _noteNotifier.editNote(note.copyWith(isSoftDeleted: false));

        break;
      case SlidableMenuValue.hard_delete:
        await _noteNotifier.hardDeleteNote(note);

        break;
      case SlidableMenuValue.archive:
        await _noteNotifier.editNote(note.copyWith(isArchived: true));

        break;
      case SlidableMenuValue.unarchive:
        await _noteNotifier.editNote(note.copyWith(isArchived: false));

        break;
      case SlidableMenuValue.bookmark:
        await _noteNotifier.editNote(note.copyWith(isBookmarked: true));

        break;
      case SlidableMenuValue.unbookmark:
        await _noteNotifier.editNote(note.copyWith(isBookmarked: false));

        break;
      default:
    }
  }
}
