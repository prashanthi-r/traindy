import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dictionary_app/models/word.dart';

Future<List<dynamic>> pushuserProfile(var result) async {
  print(result);
  var url = Uri.parse('http://127.0.0.1:5000/user');
  var get_uri = Uri.parse('http://127.0.0.1:5000/recco');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'age': result[0],
      'fn': result[1],
      'cms': result[2],
      'au': result[3],
    }),
  );
  var recs = jsonDecode(response.body);
  return recs;
}
