import 'package:flutter/material.dart';
import 'package:mononocle2/api/firebase/decks/deck_api.dart';
import 'package:mononocle2/deck/sliver/deck_detail.dart';
import 'package:mononocle2/models/deck_model.dart';
import '../../utils/widgets.dart';

class DeckSliverList extends StatefulWidget {

  @override
  _DeckSliverListState createState() => _DeckSliverListState();
}
Future<List<Deck>>? _futureOfDecks;

class _DeckSliverListState extends State<DeckSliverList> {
  @override
  void initState() {
    _futureOfDecks = DeckReader.getDecks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget sliverView = getSliverList();
    return sliverView;
  }

  void reload(){
    setState(() {

    });
  }

  Widget getSliverList(){
    Widget sliverList = FutureBuilder(
        future: _futureOfDecks,
        builder: (BuildContext context, AsyncSnapshot<List<Deck>> snapshot){
          if(snapshot.hasData){
            List<Deck> allDecks = snapshot.data!;
            List<Widget> doneDecks = [];
            List<Widget> notDoneDecks = [];
            List<Widget> deck = [];

            for(var i in allDecks){
              if(i.date == convertTime(DateTime.now())){
                deck.add(makeTile(i));
              }else if(i.isDone==false){
                notDoneDecks.add(makeTile(i));
              }else{
                doneDecks.add(makeTile(i));
              }

            }

            return CustomScrollView(
              slivers: [
                makeHeader("Today", Colors.green),
                SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [...deck]
                    )),
                makeHeader("Not Done", Colors.lightGreen),
                SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        [...notDoneDecks]
                    )),
                makeHeader("Done", Colors.blueGrey),
                SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        [...doneDecks]
                    )),
              ],
            );
          }else{
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              ),
            );
          }
        },
    );

    return sliverList;
  }


  Widget makeHeader(String headerText, MaterialColor color) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeadBarDelegate(
        minHeight: 60.0,
        maxHeight: 100.0,
        child: GestureDetector(
          child: Container(
              color: color,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30.0, 0, 20.0),
                    child: Text(
                        headerText,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ]
              ),
          ),
        ),
      ),
    );
  }

  Widget makeTile(Deck deck){
    return ListTile(
      tileColor: Colors.black,
      hoverColor: Colors.black26,
      title: Text(
        deck.getDate,
        style: TextStyle(
          color: deck.isDone?Colors.white38:Colors.white,
          fontSize: 24,
        ),
      ),
      subtitle: Text(
        deck.words.length.toString(),
        style: TextStyle(
          color: deck.isDone?Colors.white38:Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return DeckDetailPage(deck: deck, reload: reload,);
            }),
         );
      },
    );
  }


}
