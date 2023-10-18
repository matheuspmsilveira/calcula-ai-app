import 'package:calcula_ai/src/providers/papers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViewProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeTab(int newIndex, BuildContext context) {
    Provider.of<PapersProvider>(context, listen: false).fetchPapers();
    _currentIndex = newIndex;
    notifyListeners();
  }
}
