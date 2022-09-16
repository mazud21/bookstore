
import 'package:bookstore/providers/load_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoadData(),
        )
      ],
      child: MaterialApp(
        home: BookStore(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
