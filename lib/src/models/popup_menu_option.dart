import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';

enum PopupMenuValue {
  soft_delete,
  hard_delete,
  restore,
  archive,
  unarchive,
  bookmark,
  unbookmark
}

class PopupMenuOption {
  PopupMenuValue value;
  String label;
  IconData iconData;

  PopupMenuOption({this.value, this.label, this.iconData});
}

List<PopupMenuOption> deletedNoteOptions = [
  PopupMenuOption(
      value: PopupMenuValue.hard_delete,
      label: 'Delete Forever',
      iconData: Icons.ac_unit),
  PopupMenuOption(
      value: PopupMenuValue.restore, label: 'Restore', iconData: Icons.ac_unit),
];

final popUpMenuOptions = [
  PopupMenuOption(
      value: PopupMenuValue.archive, label: 'Archive', iconData: Icons.ac_unit),
  PopupMenuOption(
      value: PopupMenuValue.unarchive,
      label: 'Unarchive',
      iconData: Icons.ac_unit),
  PopupMenuOption(
      value: PopupMenuValue.soft_delete,
      label: 'Delete',
      iconData: Icons.ac_unit),
];

List<PopupMenuOption> getMenuOptionsForNote({Note note}) {
  List<PopupMenuOption> menuOptions = [
    // Unarchived note options
    if (!note.isArchived && !note.isSoftDeleted) ...[
      PopupMenuOption(
          value: PopupMenuValue.archive,
          label: 'Archive',
          iconData: Icons.ac_unit),
      PopupMenuOption(
          value: PopupMenuValue.soft_delete,
          label: 'Delete',
          iconData: Icons.ac_unit),
      if (note.isBookmarked)
        PopupMenuOption(
            value: PopupMenuValue.unbookmark,
            label: 'Unbookmark',
            iconData: Icons.ac_unit),
      if (!note.isBookmarked)
        PopupMenuOption(
            value: PopupMenuValue.bookmark,
            label: 'Bookmark',
            iconData: Icons.ac_unit),
    ],
    // Archived note options
    if (note.isArchived && !note.isSoftDeleted) ...[
      PopupMenuOption(
          value: PopupMenuValue.unarchive,
          label: 'Unarchive',
          iconData: Icons.ac_unit),
      PopupMenuOption(
          value: PopupMenuValue.soft_delete,
          label: 'Delete',
          iconData: Icons.ac_unit),
    ],
    if (note.isSoftDeleted)
      ...deletedNoteOptions
  ];

  // // Unarchived note
  // if (!note.isArchived && !note.isSoftDeleted) {
  //   menuOptions.addAll(
  //     [
  //       PopupMenuOption(
  //           value: PopupMenuValue.archive,
  //           label: 'Archive',
  //           iconData: Icons.ac_unit),
  //       PopupMenuOption(
  //           value: PopupMenuValue.soft_delete,
  //           label: 'Delete',
  //           iconData: Icons.ac_unit),
  //       if (note.isBookmarked)
  //         PopupMenuOption(
  //             value: PopupMenuValue.unbookmark,
  //             label: 'Unbookmark',
  //             iconData: Icons.ac_unit),
  //       if (!note.isBookmarked)
  //         PopupMenuOption(
  //             value: PopupMenuValue.bookmark,
  //             label: 'Bookmark',
  //             iconData: Icons.ac_unit),
  //     ],
  //   );
  // }

  // //Archived Note
  // if (note.isArchived && !note.isSoftDeleted) {
  //   menuOptions.addAll([
  //     PopupMenuOption(
  //         value: PopupMenuValue.unarchive,
  //         label: 'Unarchive',
  //         iconData: Icons.ac_unit),
  //     PopupMenuOption(
  //         value: PopupMenuValue.soft_delete,
  //         label: 'Delete',
  //         iconData: Icons.ac_unit),
  //   ]);
  // }

  // // Soft deleted note
  // if (note.isSoftDeleted) menuOptions.addAll(deletedNoteOptions);

  return menuOptions;
}
