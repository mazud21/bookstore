import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book_model.dart';
import '../providers/load_data.dart';
import 'book_detail.dart';

class ListSearchBook extends StatefulWidget {

  @override
  _ListSearchBookState createState() => _ListSearchBookState();
}

class _ListSearchBookState extends State<ListSearchBook> {

  TextEditingController etSearch = TextEditingController();

  List<BooksModel>? bookModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   bookModel?.clear();
  }

  @override
  Widget build(BuildContext context) {

    Widget search = Container(
      child: TextFormField(
        autofocus: true,
        controller: etSearch,
        onFieldSubmitted: (value) {
          Provider.of<LoadData>(context, listen: false).getSearchListBook(value);
        },
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
              height: MediaQuery.of(context).size.height*0.81,
              child: RefreshIndicator(
                onRefresh: () {
                  return Provider.of<LoadData>(context, listen: false).getSearchListBook(etSearch.text);
                },
                color: Colors.red,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: FutureBuilder(
                    future: Provider.of<LoadData>(context, listen: false)
                        .getSearchListBook(etSearch.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            radius: 15, color: Colors.green,
                          ),
                        );
                      }
                      return Consumer<LoadData>(
                        builder: (context, data, _) {
                          return ListView.builder(
                            itemCount: data.dataBook.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BooksDetail(
                                        id: data.dataBook[i].isbn13 as String,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 8,
                                  child: ListTile(
                                    leading: Image.network(data.dataBook[i].image as String),
                                    title: Text(
                                      data.dataBook[i].title as String,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        '${data.dataBook[i].subtitle}'),
                                    trailing: Text(
                                        "${data.dataBook[i].price}"),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
