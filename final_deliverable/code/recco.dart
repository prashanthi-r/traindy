import 'package:flutter/material.dart';
import 'package:dictionary_app/screens/search.dart';
import 'package:google_fonts/google_fonts.dart';

class prodList extends StatefulWidget {
  var products;

  prodList(this.products);

  @override
  State<prodList> createState() => _prodListState(products);
}

class _prodListState extends State<prodList> {
  var products;
  _prodListState(this.products);

  List<Widget> getCards() {
    List<Widget> cards = [];
    for (var i = 0; i < products.length; i++) {
      cards.add(_buildCard(
          products[i][1],
          '\$3.99',
          '/Users/adidot/DS1951Web/Webapp/images/${products[i][0]}.jpg',
          false,
          context));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xff241424)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xffffc200),
        title: Text('Personalized Recommendations'),
        titleTextStyle:
            GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
      ),
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 300.0, left: 300),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 50.0,
                mainAxisSpacing: 80.0,
                childAspectRatio: 0.8,
                children: getCards(),
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(
      String name, String price, String imgPath, bool added, context) {
    bool isFavorite = false;
    return Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: InkWell(
            onTap: () {
              setState(() {
                isFavorite = true;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    color: Color(0xFFEF7532))
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              imgPath,
                              width: 100.0,
                              height: 200.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 30.0),
                  Text(
                    name,
                    style: GoogleFonts.rubik(
                        fontSize: 25, color: Color(0xff241424)),
                  ),
                ]))));
  }
}



/*
[
                  _buildCard(
                      'Cookie mint',
                      '\$3.99',
                      '/Users/adidot/DS1951Web/Webapp/images/0108775015.jpg',
                      false,
                      false,
                      context),
                  _buildCard(
                      'Cookie cream',
                      '\$5.99',
                      '/Users/adidot/DS1951Web/Webapp/images/0120129001.jpg',
                      true,
                      false,
                      context),
                  _buildCard(
                      'Cookie classic',
                      '\$1.99',
                      '/Users/adidot/DS1951Web/Webapp/images/0174057022.jpg',
                      false,
                      true,
                      context),
                  _buildCard(
                      'Cookie choco',
                      '\$2.99',
                      '/Users/adidot/DS1951Web/Webapp/images/0181160009.jpg',
                      false,
                      false,
                      context)
                ]
*/