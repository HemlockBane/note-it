import 'package:flutter/material.dart';


class AppBottomNavigationBarItem{
  AppBottomNavigationBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class AppBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List <AppBottomNavigationBarItem> items;

  const AppBottomNavigationBar({this.onTabSelected, this.items});
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
