import 'dart:convert';

List<Word> wordFromJson(String str) => List<Word>.from(json.decode(str).map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDefinitions{
  AllDefinitions(this.words);

  List<Word> words;

}

class Word {
  Word({
    required this.word,
    this.phonetic,
    required this.meanings,
  });

  String word;
  String? phonetic;
  List<Meaning> meanings;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    word: json["word"],
    phonetic: json["phonetic"],
    meanings: List<Meaning>.from(json["meanings"].map((x) => Meaning.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "phonetic": phonetic,
    "meanings": List<dynamic>.from(meanings.map((x) => x.toJson())),
  };
}


class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    this.synonyms,
    this.antonyms,
  });

  String partOfSpeech;
  List<Definition> definitions;
  List<String>? synonyms;
  List<dynamic>? antonyms;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
    partOfSpeech: json["partOfSpeech"],
    definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromJson(x))),
    synonyms: List<String>.from(json["synonyms"].map((x) => x)),
    antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "partOfSpeech": partOfSpeech,
    "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
    "synonyms": synonyms != null?List<dynamic>.from(synonyms!.map((x) => x)):null,
    "antonyms": antonyms != null?List<dynamic>.from(antonyms!.map((x) => x)):null,
  };
}

class Definition {
  Definition({
    required this.definition,
    this.example,
  });

  String definition;
  String? example;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
    definition: json["definition"],
    example: json["example"],
  );

  Map<String, dynamic> toJson() => {
    "definition": definition,
    "example": example,
  };
}
