import 'package:flutter/material.dart';
import 'package:mononocle2/api/analysis/analysis_api.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage();

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  late Future _futureOfScore;

  @override
  void initState() {
    _futureOfScore = ScoreReader.readScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder(
          future: _futureOfScore,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            int lookups = snapshot.data;
            if(snapshot.hasData){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "You have looked up $lookups words",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 30
                    ),
                  ),
                ),
              );
            }else{
              return Center(
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
              );
            }
          },
        ),
      ),
    );
  }
}

