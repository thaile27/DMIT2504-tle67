// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:async';
import '../services/network.dart';

const apiToken = 'QTVXCOASBD3ZIC1J';
// API library: https://openlibrary.org/dev/docs/api/search

class StockService {
  Future getCompanyInfo(String title) async {
    var urlUsingOneString =
        Uri.parse('https://openlibrary.org/search.json?title=$title');

    NetworkService networkService = NetworkService(urlUsingOneString);
    var data = await networkService.getData();
    print(data['docs'][0]);
    return data['docs'][0];
  }

//   Future getQuote(String symbol) async {
//     var url = Uri.parse(
//         'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken');

//     print('url: $url');
//     NetworkService networkService = NetworkService(url);
//     var data = await networkService.getData();
//     print(data['Global Quote']['05. price']);
//     return data;
//   }
}
