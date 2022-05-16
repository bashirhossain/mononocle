import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mononocle2/dictionary/dictionary_page.dart';

class Dictionary extends StatelessWidget {
  Dictionary({
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
          "The Dictionary",
          style: GoogleFonts.ubuntu(
            fontSize: 30,
            color: Colors.white54
          ),
        ),
      ),
      drawer: drawer,
      body: DictionaryPage(),
    );
  }
}
