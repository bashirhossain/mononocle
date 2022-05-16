import 'package:flutter/material.dart';
import 'navigation-widget.dart';

class PageViewed extends ChangeNotifier{
  PageBeingViewed _pageBeingViewed = PageBeingViewed.dictionary;

  PageBeingViewed get pageBeingViewed => _pageBeingViewed;
  void switchToDictionary(){
    if(_pageBeingViewed!=PageBeingViewed.dictionary) {
      _pageBeingViewed = PageBeingViewed.dictionary;
      notifyListeners();
    }
  }

  void switchToAnalysis(){
    if(_pageBeingViewed!=PageBeingViewed.analysis) {
      _pageBeingViewed = PageBeingViewed.analysis;
      notifyListeners();
    }
  }
  void switchToDeck(){
    if(_pageBeingViewed!=PageBeingViewed.deck) {
      _pageBeingViewed = PageBeingViewed.deck;
      notifyListeners();
    }
  }
}