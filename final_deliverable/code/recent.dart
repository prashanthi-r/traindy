import 'package:dictionary_app/screens/search.dart';
import 'package:styled_text/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/models/word.dart';
import 'package:dictionary_app/widgets/dictionaryCard.dart';

class recentSearches extends StatefulWidget {
  final Map<String, Word> recent_cache;
  final cache;

  recentSearches(this.recent_cache, this.cache);

  @override
  _recentSearchesState createState() =>
      _recentSearchesState(recent_cache, cache);
}

class _recentSearchesState extends State<recentSearches> {
  Map<String, Word> recent_cache;
  var cache;

  _recentSearchesState(this.recent_cache, this.cache);

  Widget recentList() {
    List<Widget> recent = [];

    for (String w in cache) {
      recent.add(
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => searchScreen(recent_cache[w], 1),
                ));
          },
          child: Card(
              elevation: 0.3,
              color: Color(0xfffdfcfc),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 12.0, bottom: 12.0, left: 15, right: 15),
                child: Text(
                  w,
                  style: TextStyle(fontSize: 15),
                ),
              )),
        ),
      );
    }
    return ListView(shrinkWrap: true, children: recent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text('Recent Search',
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 15,
      ),
      recentList()
    ]);
  }
}
