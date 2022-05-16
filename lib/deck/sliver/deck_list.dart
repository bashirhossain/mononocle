import 'package:flutter/material.dart';
import 'package:mononocle2/api/firebase/decks/deck_api.dart';
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
    _futureOfDecks = Reader.getDecks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget sliverView = getSliverList();
    return sliverView;
  }

  Widget getSliverList(){
    Widget sliverList = FutureBuilder(
        future: _futureOfDecks,
        builder: (BuildContext context, AsyncSnapshot<List<Deck>> snapshot){
          if(snapshot.hasData){
            List<Deck> allDecks = snapshot.data!;
            List<ListTile> decks = [];

            for(var i in allDecks){
              print(i.toJson());
            }

            return CustomScrollView(
              slivers: [
                makeHeader("Today", Colors.green),
                makeHeader("Not Done", Colors.lightGreen),
                makeHeader("Done", Colors.blueGrey),
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
      hoverColor: Colors.black12,
      title: Text(
        deck.getDate,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: (){
        showDialog(
            context: context,
            builder: (context){
              return Container();
            }
         );
      },
    );
  }


}
