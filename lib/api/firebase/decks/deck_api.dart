import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mononocle2/utils/widgets.dart';
import '../../../models/deck_model.dart';

class DeckReader{

  static List<dynamic>? allDecks;

  static Future<List<dynamic>?> readDecks() async{
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> allData;

    await FirebaseFirestore
        .instance
        .collection('decks')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allData = documentSnapshot.data() as Map<String,dynamic>;
        allDecks = allData["decks"]["deckArray"];
      }
    });
    return allDecks;
  }

  static Future<List<Deck>> getDecks() async {
    await readDecks();
    List<Deck> allDeckReady = [];
    allDecks?.forEach((element) {
      allDeckReady.add(Deck.fromJson(element));
    });
    print(allDeckReady.length);
    return allDeckReady;
  }
}


class DeckWriter{
  static CollectionReference decks = FirebaseFirestore.instance.collection('decks');

  static Future<void> upDeck(Deck deck) async {
    List<Deck> allDecksReady = await DeckReader.getDecks();
    bool wasThere = false;
    for(var i in allDecksReady){
      if(i.date == deck.date){
        allDecksReady[allDecksReady.indexOf(i)].words.addAll(deck.words);
        wasThere = true;
      }
    }

    if(!wasThere){
      allDecksReady.add(deck);
    }

    List<dynamic> allDeckArray = [];
    allDecksReady.forEach((element) {
      allDeckArray.add(element.toJson());
    });

    return decks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'decks':{
          'deckArray': allDeckArray,
    }
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> addToDeck(String word, int days) async {
    Deck deck = Deck(words: [word], date: convertTime(DateTime.now().add(Duration(days: days))), isDone: false);
    await upDeck(deck);
  }

  static Future<void> changeDone(String date) async {
    List<Deck> allDecks = await DeckReader.getDecks();
    for(var i in allDecks){
      if(i.date==date){
        allDecks[allDecks.indexOf(i)].isDone = !(allDecks[allDecks.indexOf(i)].isDone);
        break;
      }
    }
    List<dynamic> allDeckArray = [];

    allDecks.forEach((element) {
      allDeckArray.add(element.toJson());
    });

    return decks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'decks':{
      'deckArray': allDeckArray,
    }
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

}