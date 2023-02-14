// ignore_for_file: prefer_const_constructors, unnecessary_new, duplicate_ignore, camel_case_types

import 'package:dictionary_app/screens/recco.dart';
import 'package:dictionary_app/widgets/recent.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/widgets/dictionaryCard.dart';
import 'package:dictionary_app/services/dictionaryApi.dart';
import 'package:dictionary_app/models/word.dart';
import 'package:dictionary_app/widgets/recent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_app/screens/recco.dart';
import 'dart:collection';

class searchScreen extends StatefulWidget {
  var getWord;
  var showCard;

  searchScreen(this.getWord, this.showCard);

  @override
  _searchScreenState createState() => _searchScreenState(getWord, showCard);
}

class _searchScreenState extends State<searchScreen> {
  final TextEditingController wordController = TextEditingController();
  var showCard = 0;
  var getWord;
  var fn = '';
  var cms = '';
  var au = '';
  var result;
  Map<String, Word> recent_cache = {};
  var cache = Queue<String>();

  _searchScreenState(this.getWord, this.showCard);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffdfcfc),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: const Color(0xffffc200),
          title: Text('H&M Recommendation Engine'),
          titleTextStyle:
              GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 80.0,
            ),
            Text(
              'Age',
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Color(0xff241424),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 2.5,
                ),
                Container(
                    margin: new EdgeInsets.only(left: 25),
                    alignment: Alignment.topCenter,
                    height: 50,
                    width: width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfff4f5f4),
                    ),
                    child: TextField(
                        textAlign: TextAlign.center,
                        controller: wordController,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide.none,
                              //borderSide: const BorderSide(),
                            ),
                            hintText: 'Enter Age',
                            hintStyle: TextStyle(color: Colors.grey[400])))),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 2.5,
                ),
                Text(
                  'How often do you read fashion news?',
                  style: GoogleFonts.rubik(
                    fontSize: 20,
                    color: Color(0xff241424),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: width / 6,
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 3, color: const Color(0xfff4f5f4)))),
                items: <String>['Regularly', 'Monthly', 'Never']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fn = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(
                  width: width / 2.27,
                ),
                Text('Club Member Status',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Color(0xff241424),
                    )),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: width / 6,
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 3, color: const Color(0xfff4f5f4)))),
                items: <String>['Active', 'Pre-create', 'Left CLub', 'None']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    cms = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(
                  width: width / 2.15,
                ),
                Text(
                  'Active User',
                  style: GoogleFonts.rubik(
                    fontSize: 20,
                    color: Color(0xff241424),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: width / 6,
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 3, color: const Color(0xfff4f5f4)))),
                items: <String>['Yes', 'No'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    au = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FlatButton.icon(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  color: const Color(0xffffc200),
                  onPressed: () async {
                    setState(() {
                      result = [wordController.text, fn, cms, au];
                    });
                    var response = await pushuserProfile(result);
                    print(response);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => prodList(response)),
                    );
                  },
                  icon: Icon(Icons.all_inclusive_rounded),
                  label: Text(
                    'Get Recommendations',
                    style: GoogleFonts.rubik(
                        fontSize: 15, color: Color(0xff241424)),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
