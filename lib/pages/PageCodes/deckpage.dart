import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mononocle2/deck/deckpage.dart';
import 'package:mononocle2/models/deck_model.dart';
import 'package:mononocle2/utils/widgets.dart';
import '../../api/firebase/decks/deck_api.dart';

class DeckPageCode extends StatelessWidget {
  DeckPageCode({
    required this.drawer,
    required this.signOutButton
  });
  final Drawer drawer;
  final IconButton signOutButton;

  Deck deck = Deck(words: ["words"], date: convertTime(DateTime.now()), isDone: false);

  @override
  Widget build(BuildContext context) {
    Reader.getDecks();
    Writer.upDeck(deck);
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
