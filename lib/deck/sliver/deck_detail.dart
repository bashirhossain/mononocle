import 'package:flutter/material.dart';
import 'package:mononocle2/api/dictionaryapi/api_manager.dart';
import 'package:mononocle2/api/firebase/decks/deck_api.dart';
import 'package:mononocle2/dictionary/word/word_page.dart';
import 'package:mononocle2/utils/widgets.dart';
import '../../models/deck_model.dart';

class DeckDetailPage extends StatefulWidget {
  DeckDetailPage({Key? key, required this.deck, required this.reload}) : super(key: key);

  Deck deck;
  void Function() reload;

  @override
  State<DeckDetailPage> createState() => _DeckDetailPageState();
}

class _DeckDetailPageState extends State<DeckDetailPage> {
  void fillDefinitions(){
    for(var i in widget.deck.words){
      getWord(i).then((value) => widget.deck.allDefinitions.add(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    fillDefinitions();
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      DeckWriter.changeDone(widget.deck.date);
                      setState(() {
                        widget.reload();
                      });
                    },
                    icon: Icon(
                        widget.deck.isDone?Icons.check_box:Icons.check_box_outline_blank_sharp,
                      color: widget.deck.isDone?Colors.white:Colors.black,
                    ),
                ),
              ],
              backgroundColor: Colors.red,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 0.0),
                child: Text(
                  widget.deck.getDate,
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
                return ListTile(
                  tileColor: Colors.black,
                  hoverColor: Colors.black12,
                  title: Text(
                    widget.deck.words[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return WordPage(allDefinitions: widget.deck.allDefinitions[index]);
                            }
                        ),
                    );
                  },
                );
              },
              childCount: widget.deck.words.length,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
