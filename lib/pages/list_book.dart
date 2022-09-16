import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/load_data.dart';
import 'book_detail.dart';

class ListBook extends StatefulWidget {

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<LoadData>(context, listen: false).getListBook();
        },
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<LoadData>(context, listen: false)
                .getListBook(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(
                  radius: 15, color: Colors.green,
                  )
                );
              }
              return Consumer<LoadData>(
                builder: (context, data, _) {
                  return ListView.builder(
                      itemCount: data.dataBook.length,
                      itemBuilder: (context, i){
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                BooksDetail(
                                  id: data.dataBook[i].isbn13 as String,
                                ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          leading: Image.network(
                              data.dataBook[i].image as String),
                          title: Text(
                            data.dataBook[i].title as String,
                            style: const TextStyle(
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
    );
  }
}
