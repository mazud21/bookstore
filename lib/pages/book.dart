import 'package:bookstore/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list_book.dart';

class BookStore extends StatefulWidget {

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  TextEditingController etSearch = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    Widget search = Container(
      child: TextFormField(
        controller: etSearch,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListSearchBook(),
            ),
          );
        },
        /*onEditingComplete: () {
          Provider.of<BooksModel>(context, listen: false).getBookStore(etSearch.text);
        },*/
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.07,
              child: search,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.82,
              child: ListBook(),
            ),
          ],
        ),
      ),
    );
  }
}
