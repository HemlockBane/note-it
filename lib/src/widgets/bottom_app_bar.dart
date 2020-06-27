import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AppBottomNavigationBarItem {
  AppBottomNavigationBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}

class AppBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List <AppBottomNavigationBarItem> items;
  final Color color;
  final Color selectedColor;
  final double height;
  final double iconSize;


  const AppBottomNavigationBar(
    {this.onTabSelected, this.items, this.color = Colors.grey, this.selectedColor = Colors.black, this.height = 60, this.iconSize = 24});

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _items(),
      ),
    );
  }

  List<Widget> _items() {
    return List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        navigationBarItem: widget.items[index],
        index: index,
        onPressed: _updateSelectedIndex
      );
    });
  }

  Widget _buildTabItem(
    {AppBottomNavigationBarItem navigationBarItem, int index, ValueChanged<int> onPressed}) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(navigationBarItem.iconData, color: color, size: widget.iconSize,),
                Text(navigationBarItem.text, style: TextStyle(
                  color: color
                ),)
              ],
            ),
          ),
        ),
      )
    );
  }

  _updateSelectedIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
