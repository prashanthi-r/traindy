// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:styled_text/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/models/word.dart';

class dictionaryCard extends StatefulWidget {
  Word displayWord;
  dictionaryCard(this.displayWord);

  @override
  _dictionaryCardState createState() => _dictionaryCardState(displayWord);
}

class _dictionaryCardState extends State<dictionaryCard> {
  Word displayWord;
  _dictionaryCardState(this.displayWord);

  List<Widget> getSynonyms() {
    List<Widget> synonyms = [];
    for (String syn in displayWord.synonyms) {
      synonyms.add(Container(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 14, left: 14, top: 5, bottom: 5),
          child: Text(syn[0].toUpperCase() + syn.substring(1),
              style: TextStyle(fontSize: 12, color: Colors.grey[800])),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color(0xffededed),
        ),
      ));
    }
    return synonyms;
  }

  String getDefinition() {
    String definition = displayWord.meaning.isNotEmpty
        ? '<bold>Definition</bold>: ' + displayWord.meaning
        : '';
    return definition;
  }

  String getOrigin() {
    String origin = displayWord.origin.isNotEmpty
        ? '<bold>Origin</bold>: ' + displayWord.origin
        : '';
    return origin;
  }

  String getTitle() {
    String title = displayWord.word.isNotEmpty ? displayWord.word : '';
    return title;
  }

  Widget wordCard() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                getTitle()[0].toUpperCase() + getTitle().substring(1),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              getDefinition().isNotEmpty
                  ? Row(children: [
                      Expanded(
                        child: StyledText(
                          text: getDefinition(),
                          tags: {
                            'bold': StyledTextTag(
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          },
                        ),
                      )
                    ])
                  : Container(),
              SizedBox(
                height: 15,
              ),
              getOrigin().isNotEmpty
                  ? Row(children: [
                      Expanded(
                        child: StyledText(
                          text: getOrigin(),
                          tags: {
                            'bold': StyledTextTag(
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          },
                        ),
                      )
                    ])
                  : Container(),
              getOrigin().isNotEmpty
                  ? SizedBox(
                      height: 15,
                    )
                  : Container(),
              getSynonyms().isNotEmpty
                  ? Text('Synonyms: ',
                      style: TextStyle(fontWeight: FontWeight.bold))
                  : Container(),
              getSynonyms().isNotEmpty
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
              getSynonyms().isNotEmpty
                  ? Wrap(
                      spacing: 10.0,
                      runSpacing: 12.0,
                      children: getSynonyms(),
                    )
                  : Container()
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    displayWord = widget.displayWord;
    return Center(child: wordCard());
  }
}
