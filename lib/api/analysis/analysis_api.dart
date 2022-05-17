import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreReader{

  static int score = 0;

  static Future<int> readScore() async{
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> allData;

    await FirebaseFirestore
        .instance
        .collection('scores')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allData = documentSnapshot.data() as Map<String,dynamic>;
        score = allData["lookups"];
      }
    });
    return score;
  }
}


class ScoreWriter{
  static CollectionReference scores = FirebaseFirestore.instance.collection('scores');

  static Future<void> addScore() async {
    int score = await ScoreReader.readScore();

    return scores
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"lookups": (score + 1)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}