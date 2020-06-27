import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';

enum PopupMenuValue { soft_delete, hard_delete, restore, archive, unarchive }

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
  List<PopupMenuOption> menuOptions = [];
  // Unarchived note
  if (!note.isArchived && !note.isSoftDeleted) {
    menuOptions.addAll(
      [
        PopupMenuOption(
            value: PopupMenuValue.archive,
            label: 'Archive',
            iconData: Icons.ac_unit),
        PopupMenuOption(
            value: PopupMenuValue.soft_delete,
            label: 'Delete',
            iconData: Icons.ac_unit),
      ],
    );
  }

  //Archived Note
  if (note.isArchived && !note.isSoftDeleted) {
    menuOptions.addAll([
      PopupMenuOption(
          value: PopupMenuValue.unarchive,
          label: 'Unarchive',
          iconData: Icons.ac_unit),
      PopupMenuOption(
          value: PopupMenuValue.soft_delete,
          label: 'Delete',
          iconData: Icons.ac_unit)
    ]);
  }

  // Soft deleted note
  if (note.isSoftDeleted) menuOptions.addAll(deletedNoteOptions);

  // return popUpMenuOptions;
  return menuOptions;
}
