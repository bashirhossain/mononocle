import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mononocle2/deck/deckpage.dart';

class DeckPageCode extends StatelessWidget {
  DeckPageCode({
    required this.drawer,
    required this.signOutButton
  });
  final Drawer drawer;
  final IconButton signOutButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "The Decks",
          style: GoogleFonts.ubuntu(
              fontSize: 30,
              color: Colors.white54
          ),
        ),
      ),
      drawer: drawer,
      body: DeckPage(),
    );
  }
}
