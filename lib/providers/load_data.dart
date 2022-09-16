import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book_model.dart';

class LoadData extends ChangeNotifier {

  List<BooksModel> _data = [];
  List<BooksModel> get dataBook => _data;

  Future<List<BooksModel>> getListBook() async {
    String url = 'https://api.itbook.store/1.0/new';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['books'].cast<Map<String, dynamic>>();
      _data = result.map<BooksModel>((json) => BooksModel.fromJson(json)).toList();
      log('CHECK_RESULT0: $result');

      notifyListeners();
      return _data;
    } else {
      throw Exception();
    }

  }

  Future<List<BooksModel>> getSearchListBook(String search) async {
    String url = 'https://api.itbook.store/1.0/search/$search';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['books'].cast<Map<String, dynamic>>();
      _data = result.map<BooksModel>((json) => BooksModel.fromJson(json)).toList();
      log('CHECK_RESULT0: $result');

      notifyListeners();
      return _data;
    } else {
      throw Exception();
    }

  }

}