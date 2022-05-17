import 'package:flutter/material.dart';
import 'package:mononocle2/api/firebase/decks/deck_api.dart';
import 'package:mononocle2/models/word_model.dart';
import 'package:mononocle2/utils/widgets.dart';

class WordPage extends StatelessWidget {
  const WordPage({Key? key, required this.allDefinitions}) : super(key: key);

  final AllDefinitions allDefinitions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.red,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 0.0),
              child: Text(
                allDefinitions.words[0].word.toUpperCase(),
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.black
                ),
              ),
            ),
            expandedHeight: 160.0,
            snap: true,
            floating: true,
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index){
                    return makeTile(
                        context,
                        allDefinitions.words[0],
                        index,
                        (){
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  backgroundColor: Colors.black,
                                  content: Row(
                                    children: [
                                      Expanded(
                                          child: StyledButton(
                                              child: const Text("Add to Deck") , 
                                              onPressed: (){
                                                DeckWriter.addToDeck(allDefinitions.words[0].word, 3);
                                                Navigator.pop(context);
                                              }
                                          )
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                          child: StyledButton(
                                              child: const Text("Rate the word") ,
                                              onPressed: (){
                                                print("click");
                                                Navigator.pop(context);
                                              })
                                      ),
                                    ],
                                  ),
                                );
                              },
                          );
                        }
                    );
                  },
            childCount: allDefinitions.words[0].meanings.length,
          ),
          ),
        ],
      ),
    );
  }
}
