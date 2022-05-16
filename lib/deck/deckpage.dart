import 'package:flutter/material.dart';
import 'sliver/deck_list.dart';

class DeckPage extends StatelessWidget {
  DeckPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DeckSliverList(),
    );
  }
}

