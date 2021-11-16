

import 'package:exam/carousel.dart';
import 'package:exam/lib.dart';
import 'package:exam/product.dart';
import 'package:exam/service.dart';
import 'package:flutter/material.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'newspaper', home: BuildWeb());
  }
}

class BuildWeb extends StatefulWidget {
  const BuildWeb({Key? key}) : super(key: key);

  @override
  _BuidlWeblState createState() => _BuidlWeblState();
}

class _BuidlWeblState extends State<BuildWeb> {
  late Size size;
  int count = 0;
  int i = 0;

  var arr = [
    Service().fetchDataTesla(Value().wallstreet),
    Service().fetchDataTesla(Value().Tc),
    Service().fetchDataTesla(Value().apple),
    Service().fetchDataTesla(Value().business),
    Service().fetchDataTesla(Value().Tesla),

  ];

  var image = [
    Value().imga,
    Value().imgc,
    Value().imgd,
    Value().imge,
    Value().imgb,
  ];

  var nameStr = ["Wall Street Jounal", "Tech Crunch", "Apple", "Business", "Tesla"];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [setTitle(), setContent(), setDetail()],
      ),
    );
  }

  Widget setTitle() {
    return Container(
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Newspaper",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "News",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300]),
          )
        ],
      ),
    );
  }

  Widget setContent() {
    return Container(
      height: size.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 7, left: 7),
                  width: size.width * 0.45,
                  height: size.height * 0.135,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image[index])),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
                Text(nameStr[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19))
              ],
            ),
            onTap: () {
              setState(() {
                i = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget setDetail() {
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height * 0.84,
      child: FutureBuilder(
          future: arr[i],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Product t = snapshot.data;
              return setList(t.articles);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget setList(List<Article> ls) {
    return ListView.builder(
      itemCount: ls.length,
      itemBuilder: (BuildContext context, int index) {
        Article p = ls[index];
        return GestureDetector(
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(p.urlToImage == null || p.urlToImage == ''
                          ? Value().imge
                          : p.urlToImage),
                      Text(
                        p.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        p.content,
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => detailScreen(
                      detail: p,
                    )
                )
            );
          },
        );
      },
    );
  }
}