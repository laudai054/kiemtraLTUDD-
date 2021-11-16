import 'dart:convert';

import 'package:exam/product.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<Product> fetchDataTesla(dynamic s) async {
    String url = s == null
        ? "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=4a88eb2218b04c7d9ab0d982c2afa70b"
        : s;
    var reponse = await http.get(Uri.parse(url));
    if (reponse.statusCode == 200) {
      var jsonData = json.decode(reponse.body);
      //print(jsonData);
      Product tl = productFromJson(reponse.body);
      //print(tl);
      return tl;
    } else {
      return throw Exception('Error');
    }
  }
}