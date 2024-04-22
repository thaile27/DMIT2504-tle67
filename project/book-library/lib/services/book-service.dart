// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:async';
import '../services/network.dart';

const apiToken = 'QTVXCOASBD3ZIC1J';
// API library: https://openlibrary.org/dev/docs/api/search

class BookService {
  Future getBookData(String title) async {
    var urlUsingOneString =
        Uri.parse('https://openlibrary.org/search.json?title=$title');

    NetworkService networkService = NetworkService(urlUsingOneString);
    var data = await networkService.getData();
    print(data['docs'][0]);
    return data['docs'][0];
  }
}
