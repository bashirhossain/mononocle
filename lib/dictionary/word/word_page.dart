import 'package:flutter/material.dart';
import 'package:mononocle2/models/word_model.dart';
import 'package:mononocle2/utils/widgets.dart';

class WordPage extends StatelessWidget {
  const WordPage({Key? key, required this.allDefinitions}) : super(key: key);

  final AllDefinitions allDefinitions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                    return makeTile(context, allDefinitions.words[0], index);
                  },
            childCount: allDefinitions.words[0].meanings.length,
          ),
          ),
        ],
      ),
    );
  }
}
