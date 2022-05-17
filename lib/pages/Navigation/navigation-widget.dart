import 'package:flutter/material.dart';
import 'package:mononocle2/pages/PageCodes/analysispage.dart';
import 'package:mononocle2/pages/PageCodes/deckpage.dart';
import 'package:mononocle2/pages/PageCodes/dictionary.dart';
import '../../utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


enum PageBeingViewed{
  deck,
  dictionary,
  analysis,
}

class ViewPage extends StatelessWidget {
  ViewPage(
      {
        required this.pageBeingViewed,
        required this.switchToDeck,
        required this.switchToDictionary,
        required this.switchToAnalysis,
        required this.signOut,
      }
      );

  final PageBeingViewed pageBeingViewed;
  final void Function() switchToDeck;
  final void Function() switchToDictionary;
  final void Function() switchToAnalysis;
  final Function signOut;


  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 50, 145, 0.0),
              child: Text(
                "Mononocle",
                style: GoogleFonts.italianno(
                  color: Colors.deepPurple,
                  fontSize: 40
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.005, 145, 0.0),
              child: Text(
                "Readscape",
                style: GoogleFonts.italiana(
                    color: Colors.deepPurple,
                    fontSize: 26
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 100, 60, 0.0),
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: GoogleFonts.oxygen(
                  fontSize: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 80, 0.0, 0.0),
              child: StyledButton(
                child: Text("Dictionary"),
                onPressed: (){
                  switchToDictionary();
                  Navigator.pop(context);
                },
              ),
            ),
            StyledButton(
              child: Text("Analysis"),
              onPressed: (){
                switchToAnalysis();
                Navigator.pop(context);
              },
            ),
            StyledButton(
              child: Text("Decks"),
              onPressed: (){
                switchToDeck();
                Navigator.pop(context);
              },
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40),
              child: StyledButton(
                child: Text(
                  "SignOut",
                  style: TextStyle(
                    color: Colors.red[700]
                  ),
                ),
                onPressed: ()=>signOut(),
              ),
            ),
          ],
        ),
      ),
    );


    IconButton signOutButton = IconButton(
      onPressed: ()=>signOut(),
      icon: const Icon(Icons.exit_to_app_outlined, color: Colors.red,),
    );


    switch (pageBeingViewed){
      case PageBeingViewed.deck:
        return DeckPageCode(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      case PageBeingViewed.dictionary:
        return Dictionary(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      case PageBeingViewed.analysis:
        return AnalysisPageCode(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      default:
        return const Center(
          child: Text(
              "Something went wrong"
          ),
        );
    }
  }
}
