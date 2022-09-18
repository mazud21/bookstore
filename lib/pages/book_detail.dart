import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../models/detail_book_model.dart';

class BooksDetail extends StatefulWidget {
  final String id;

  BooksDetail({required this.id});

  @override
  _BooksDetailState createState() => _BooksDetailState();
}

class _BooksDetailState extends State<BooksDetail> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();
  bool _isLoading = false;

  final snackbarKey = GlobalKey<ScaffoldState>();

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  DetailBook? detailBook;

  @override
  void initState() {
    super.initState();

    loadDetailProses(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: detailBook == null
          ? const Center(child: CupertinoActivityIndicator(radius: 15))
          : Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Hero(
                          tag: 'img',
                          child: Image.network(
                            detailBook?.image as String,
                            width: MediaQuery.of(context).size.width * 0.50,
                          ),
                        ),
                        Text(detailBook?.title as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(
                          height: 8,
                        ),
                        Text(detailBook?.authors as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [Text('Rating', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),), Text(detailBook?.rating as String)],
                      ),
                      Column(
                        children: [Text('Language', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),), Text(detailBook?.language as String)],
                      ),
                      Column(
                        children: [Text('Pages', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),), Text(detailBook?.pages as String)],
                      ),
                      Column(
                        children: [Text('Years', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),), Text(detailBook?.year as String)],
                      ),
                    ],
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        String url = detailBook?.url as String;
                        if (await canLaunch(url)){
                        await launch(url);
                        } else {
                        // can't launch url
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color.fromRGBO(41, 97, 226, 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 16,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Buy Now ${detailBook?.price}',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('Shorts about book', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(detailBook?.desc as String),
                ],
              ),
            ),
    );
  }

  Future<String> loadDetailProses(String id) async {
    final String url = 'https://api.itbook.store/1.0/books/$id';

    var response = await http.get(Uri.parse(url));

    log('CHECK_RESPONSE: $response');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      setState(() {
        detailBook = DetailBook.fromJson(body);
      });

      return "Loaded Successfully";
    } else {
      throw Exception('Failed to send data.');
    }
  }
}
