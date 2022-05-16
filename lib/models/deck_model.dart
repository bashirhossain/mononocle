import 'package:mononocle2/models/word_model.dart';

class Deck{
  Deck({
    required this.words,
    required this.date,
    required this.isDone,
  });

  List<String> words;
  String date;
  bool isDone;
  List<AllDefinitions> allDefinitions = [];

  get dateTime => DateTime.parse(date);
  get getDate => date;

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
    date: json["date"],
    isDone: json["isDone"],
    words: List<String>.from(json["words"].map((x) => (x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "words": words,
    "isDone": isDone,
  };
}