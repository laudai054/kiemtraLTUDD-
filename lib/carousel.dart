import 'package:exam/lib.dart';
import 'package:exam/main.dart';
import 'package:exam/product.dart';
import 'package:flutter/material.dart';

class detailScreen extends StatelessWidget {

  Article detail;

  detailScreen({required this.detail, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.keyboard_backspace_outlined, size: 30)),
          title: Text("News", style: TextStyle(fontSize: 22)),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.network(detail.urlToImage == null ||
                                detail.urlToImage == ''
                                ? Value().imge
                                : detail.urlToImage),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              detail.title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Content: " + detail.content,
                              maxLines: 2,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Description: " + detail.description,
                              maxLines: 2,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                )
            )
        )
    );
  }
}