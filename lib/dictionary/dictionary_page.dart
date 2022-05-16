import 'package:flutter/material.dart';
import 'package:mononocle2/api/dictionaryapi/api_manager.dart';
import 'package:mononocle2/dictionary/word/word_page.dart';
import 'package:mononocle2/utils/widgets.dart';

class DictionaryPage extends StatelessWidget {
  DictionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getWord("word");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: WordSearch(
                workWithWord: (word){
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context){
                          return FutureBuilder(
                            future: getWord(word),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if(snapshot.hasData) {
                                  return WordPage(allDefinitions: snapshot.data);
                                }else if(snapshot.hasError){
                                  return const Center(
                                    child: Text(
                                      "Something went wrong"
                                    ),
                                  );
                                }else{
                                  return const SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  );
                                }
                            },
                          );
                        },
                    )
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}
