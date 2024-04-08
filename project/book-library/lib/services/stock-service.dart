// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:async';
import '../services/network.dart';

const apiToken = 'QTVXCOASBD3ZIC1J';
// API library: https://openlibrary.org/dev/docs/api/search

class StockService {
  Future getCompanyInfo(String symbol) async {
    var urlUsingOneString = Uri.parse(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$apiToken');

    Uri url = Uri(
        scheme: 'https',
        host: 'www.alphavantage.co',
        path: '/query',
        query: 'function=OVERVIEW&symbol=$symbol&apikey=$apiToken');
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    print(data);
    return data;
  }

  Future getQuote(String symbol) async {
    var url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken');

    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    print(data['Global Quote']['05. price']);
    return data;
  }
}
