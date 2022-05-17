import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mononocle2/Analysis/analysis.dart';
import 'package:mononocle2/deck/deckpage.dart';

class AnalysisPageCode extends StatelessWidget {
  const AnalysisPageCode({
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
          "Analysis",
          style: GoogleFonts.ubuntu(
              fontSize: 30,
              color: Colors.white54
          ),
        ),
      ),
      drawer: drawer,
      body: const AnalysisPage(),
    );
  }
}
