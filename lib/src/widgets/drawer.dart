import 'package:flutter/material.dart';
import 'package:note_it/src/notifiers/drawer_notifier.dart';
import 'package:note_it/src/screens/archived_notes.dart';
import 'package:note_it/src/screens/notes.dart';
import 'package:provider/provider.dart';

class AppDrawerTileItem {
  AppDrawerTileItem({this.title, this.iconData, this.destinationRoute});

  String title;
  IconData iconData;
  String destinationRoute;
}

final tileItems = [
  AppDrawerTileItem(
      title: 'Notes',
      iconData: Icons.note,
      destinationRoute: NotesScreen.routeName),
  AppDrawerTileItem(
      title: 'Archived Notes',
      iconData: Icons.ac_unit,
      destinationRoute: ArchivedNotesScreen.routeName)
];

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DrawerNotifier _drawerNotifier;
  Color _selectedColor = Colors.black;
  Color _unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    _drawerNotifier = DrawerNotifier.of(context);

    return SafeArea(
      child: Drawer(
        child: Consumer<DrawerNotifier>(
          builder: (context, drawer, child) {
            return ListView(
              children: <Widget>[
                ..._buildDrawerListTiles(
                    currentlySelectedIndex: drawer.currentlySelectedIndex)
              ],
            );
          },
        ),
      ),
    );
  }

  _buildDrawerListTiles({int currentlySelectedIndex}) {
    return List.generate(tileItems.length, (int index) {
      final tileItem = tileItems[index];
      Color color =
          currentlySelectedIndex == index ? _selectedColor : _unselectedColor;
      return _buildDrawerListTile(
          index: index,
          title: tileItem.title,
          iconData: tileItem.iconData,
          destinationRoute: tileItem.destinationRoute,
          color: color);
    });
  }

  Widget _buildDrawerListTile(
      {int index,
      String title,
      IconData iconData,
      String destinationRoute,
      Color color}) {
    return ListTile(
      leading: Icon(iconData, color: color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.body1.copyWith(color: color),
      ),
      onTap: () => _handleTilePress(index, destinationRoute),
    );
  }

  _handleTilePress(int index, String destinationRoute) {
    int _currentlySelectedIndex = _drawerNotifier.currentlySelectedIndex;

    if (index == _currentlySelectedIndex) {
      Navigator.pop(context); // Close drawer
      return;
    }

    Navigator.pop(context); // Close drawer
    Navigator.pushReplacementNamed(context, destinationRoute);
    _drawerNotifier.updateSelectedIndex(index);
  }
}
