import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/notifiers/drawer_notifier.dart';
import 'package:note_it/src/notifiers/theme_notifier.dart';
import 'package:note_it/src/screens/archived_notes.dart';
import 'package:note_it/src/screens/deleted_notes.dart';
import 'package:note_it/src/screens/notes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawerTileItem {
  AppDrawerTileItem({this.title, this.iconData, this.destinationRoute});

  String title;
  IconData iconData;
  String destinationRoute;
}

final tileItems = [
  AppDrawerTileItem(
      title: 'Notes',
      iconData: LineIcons.lightbulb,
      destinationRoute: NotesScreen.routeName),
  AppDrawerTileItem(
      title: 'Archived Notes',
      iconData: LineIcons.archive,
      destinationRoute: ArchivedNotesScreen.routeName),
  AppDrawerTileItem(
      title: 'Deleted Notes',
      iconData: LineIcons.trash,
      destinationRoute: DeletedNotesScreen.routeName)
];

class AppDrawer extends StatefulWidget {
  final Color selectedColor;
  final Color unselectedColor;

  AppDrawer(
      {this.selectedColor = Colors.black, this.unselectedColor = Colors.grey});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DrawerNotifier _drawerNotifier;
  ThemeNotifier _themeNotifier;

  @override
  Widget build(BuildContext context) {
    _drawerNotifier = DrawerNotifier.of(context);
    _themeNotifier = ThemeNotifier.of(context);

    return SafeArea(
      child: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Consumer<DrawerNotifier>(
            builder: (context, drawer, _) {
      
              return ListView(
                children: <Widget>[
                  ..._buildDrawerListTiles(
                      currentlySelectedIndex: drawer.currentlySelectedIndex),
                  Consumer<ThemeNotifier>(builder: (context, themeNotifier, _) {
                    final isLightMode =
                        themeNotifier.getThemeMode() == ThemeMode.light;

                    final _isSwitchSelected = isLightMode ? false : true;

                    return SwitchListTile(
                      title: Text(_isSwitchSelected ? "Dark Mode" : "Light Mode"),
                      value: _isSwitchSelected,
                      onChanged: (bool isSwitchSelected) async {
                        final themeOption = isSwitchSelected
                            ? ThemeOption.dark
                            : ThemeOption.light;
                        _themeNotifier.updateThemeOption(themeOption);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setInt(AppStrings.themeIndex, themeOption.index);
                      },
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildDrawerListTiles({int currentlySelectedIndex}) {
    return List.generate(tileItems.length, (int index) {
      final tileItem = tileItems[index];
      Color color = currentlySelectedIndex == index
          ? widget.selectedColor
          : widget.unselectedColor;
      return _buildDrawerListTile(
        index: index,
        title: tileItem.title,
        iconData: tileItem.iconData,
        destinationRoute: tileItem.destinationRoute,
        color: color,
      );
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
