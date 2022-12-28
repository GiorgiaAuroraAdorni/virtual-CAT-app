import "package:flutter/cupertino.dart";

class SelectedColorsNotifier with ChangeNotifier {
  final List<CupertinoDynamicColor> _selectedColors = <CupertinoDynamicColor>[];

  List<CupertinoDynamicColor> get colors => _selectedColors;
  bool get isEmpty => _selectedColors.isEmpty;

  void add(CupertinoDynamicColor color) {
    _selectedColors.add(color);
    notifyListeners();
  }

  bool contains(CupertinoDynamicColor color) => _selectedColors.contains(color);

  bool remove(CupertinoDynamicColor color) {
    final bool response = _selectedColors.remove(color);
    notifyListeners();

    return response;
  }

  int indexOf(CupertinoDynamicColor color) => _selectedColors.indexOf(color);

  void clear() {
    _selectedColors.clear();
    notifyListeners();
  }
}
