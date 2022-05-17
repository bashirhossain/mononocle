import 'package:flutter/material.dart';

class DeckState extends ChangeNotifier {
  void reload() {
    notifyListeners();
  }
}