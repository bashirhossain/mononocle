import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/deck_model.dart';

class Reader{

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


class Writer{
  static CollectionReference decks = FirebaseFirestore.instance.collection('decks');

  static Future<void> upDeck(Deck deck) async {
    List<Deck> allDecksReady = await Reader.getDecks();
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

}