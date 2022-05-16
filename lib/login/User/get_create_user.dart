import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? displayName = FirebaseAuth.instance.currentUser!.displayName;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference tasks = FirebaseFirestore.instance.collection('decks');
  // CollectionReference todo = FirebaseFirestore.instance.collection('todo');
  // CollectionReference record = FirebaseFirestore.instance.collection('record');
  User(){
    FirebaseFirestore.instance
        .collection('decks')
        .doc(userId).get()
        .then((DocumentSnapshot docSnapshot){
      if(!docSnapshot.exists){
        addUser();
      }
    });
  }
  void addUser(){
    addDecks();
  }

  Future<void> addDecks(){
    return tasks
        .doc(userId)
        .set({
      "decks":{
        "deckArray": [],
      },
    })
        .then((value) => print("User decks Added"))
        .catchError((error) => print("Failed to Add user decks: $error"));
  }
//   Future<void> addTodo(){
//     return todo
//         .doc(userId)
//         .set({
//       "todolist": {},
//     })
//         .then((value) => print("User Todo Added"))
//         .catchError((error) => print("Failed to Add user todo: $error"));
//   }
//   Future<void> addRecord(){
//     return record
//         .doc(userId)
//         .set({
//       "weekrecords":<Map<String, dynamic>>[],
//     })
//         .then((value) => print("User Records Added"))
//         .catchError((error) => print("Failed to Add user records: $error"));
//   }
}