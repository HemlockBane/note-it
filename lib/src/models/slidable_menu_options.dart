import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/models/note.dart';

enum SlidableMenuValue {
  soft_delete,
  hard_delete,
  restore,
  archive,
  unarchive,
  bookmark,
  unbookmark,
  share
}

class SlidableMenuOption {
  SlidableMenuValue value;
  String label;
  IconData iconData;

  SlidableMenuOption({this.value, this.label, this.iconData});
}

List<SlidableMenuOption> deletedNoteOptions = [
  SlidableMenuOption(
      value: SlidableMenuValue.hard_delete,
      label: 'Delete Forever',
      iconData: LineIcons.trash),
  SlidableMenuOption(
      value: SlidableMenuValue.restore,
      label: 'Restore',
      iconData: LineIcons.trashRestore),
];

List<SlidableMenuOption> getSlidableMenuOptionsForNote(Note note) {
  List<SlidableMenuOption> menuOptions = [
    if (!note.isSoftDeleted) ...[
      if (!note.isArchived) ...[
        SlidableMenuOption(
            value: SlidableMenuValue.archive,
            label: 'Archive',
            iconData: LineIcons.archive)
      ],
      if (note.isArchived) ...[
        SlidableMenuOption(
            value: SlidableMenuValue.unarchive,
            label: 'Unarchive',
            iconData: LineIcons.plusSquare)
      ],
      if (!note.isBookmarked) ...[
        SlidableMenuOption(
            value: SlidableMenuValue.bookmark,
            label: 'Bookmark',
            iconData: LineIcons.star)
      ],
      if (note.isBookmarked) ...[
        SlidableMenuOption(
            value: SlidableMenuValue.unbookmark,
            label: 'Unbookmark',
            iconData: LineIcons.starAlt)
      ],
      SlidableMenuOption(
          value: SlidableMenuValue.share,
          label: 'Share',
          iconData: LineIcons.share),
      SlidableMenuOption(
          value: SlidableMenuValue.soft_delete,
          label: 'Delete',
          iconData: LineIcons.trash),
    ],
    if (note.isSoftDeleted) ...deletedNoteOptions
  ];

  return menuOptions;
}
