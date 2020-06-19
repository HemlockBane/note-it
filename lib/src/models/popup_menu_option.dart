import 'package:flutter/material.dart';

class PopupMenuOption {
  PopupMenuValue value;
  String label;
  IconData iconData;

  PopupMenuOption({this.value, this.label, this.iconData});
}

enum PopupMenuValue { delete }
