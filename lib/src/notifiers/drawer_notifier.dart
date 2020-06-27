import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DrawerNotifier with ChangeNotifier {
  static DrawerNotifier of(BuildContext context) =>
      Provider.of<DrawerNotifier>(context, listen: false);

  int _currentlySelectedIndex = 0;
  int get currentlySelectedIndex => _currentlySelectedIndex;

  void updateSelectedIndex(int newIndex) {
    _currentlySelectedIndex = newIndex;
    notifyListeners();
  }
}
