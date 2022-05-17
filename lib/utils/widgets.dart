import 'package:flutter/material.dart';
import 'package:mononocle2/api/analysis/analysis_api.dart';
import 'package:mononocle2/models/word_model.dart';
import 'dart:math' as math;

class WordSearch extends StatefulWidget {
  WordSearch({Key? key, required this.workWithWord}) : super(key: key);
  String? searchedWord;
  final void Function(String) workWithWord;

  @override
  State<WordSearch> createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Word to Search",
            ),
          ),
        ),
        StyledButton(
            onPressed: (){
              widget.searchedWord = _controller.text;
              widget.workWithWord(widget.searchedWord!);
              ScoreWriter.addScore();
            },
            child: const Text(
              "Search",
            ),
        ),
      ],
    );
  }
}


Widget makeTile(BuildContext context, Word word, int index,void Function()? onTap){
  return ListTile(
    tileColor: Colors.black,
    hoverColor: Colors.black12,
    title: Text(
      word.meanings[index].partOfSpeech,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
    ),
    subtitle: Text(
      word.meanings[index].definitions[0].definition,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    onTap: onTap,
  );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      height: 60,
      width: 120,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      ),
    ),
  );
}


class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 24),
    ),
  );
}


class SliverHeadBarDelegate extends SliverPersistentHeaderDelegate{
  SliverHeadBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(SliverHeadBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

String convertTime(DateTime dateTime){
  return (dateTime.year.toString() +"-"+ dateTime.month.toString() +"-"+ dateTime.day.toString());
}
