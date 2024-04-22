// ignore_for_file: todo, avoid_print, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls, use_build_context_synchronously, unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import '../services/stock-service.dart';
import '../services/db-service.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final StockService stockService = StockService();
  final SQFliteDbService databaseService = SQFliteDbService();
  List<Map<String, dynamic>> bookList = [];
  String bookTitle = "";

  @override
  void initState() {
    super.initState();
    getOrCreateDbAndDisplayAllStocksInDb();
  }

  void getOrCreateDbAndDisplayAllStocksInDb() async {
    await databaseService.getOrCreateDatabaseHandle();
    bookList = await databaseService.getAllStocksFromDb();
    await databaseService.printAllStocksInDbToConsole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Library'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text(
              'Delete All Records and Db',
            ),
            onPressed: () async {
              await databaseService.deleteDb();
              await databaseService.getOrCreateDatabaseHandle();
              bookList = await databaseService.getAllStocksFromDb();
              await databaseService.printAllStocksInDbToConsole();
              setState(() {});
            },
          ),
          ElevatedButton(
            child: const Text(
              'Add Book',
            ),
            onPressed: () {
              inputBook();
            },
          ),
          Expanded(
            //TODO: Replace this Text child with a ListView.builder
            child: ListView.builder(
                itemCount: bookList.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Title: ${bookList[index]['title']}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      subtitle: Text(
                        'Author: ${bookList[index]['author']} ',
                        style: const TextStyle(fontSize: 10),
                      ),
                      trailing: Text(
                        'First release year: ${bookList[index]['first_publish_year']}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> inputBook() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Input Book Title'),
            contentPadding: const EdgeInsets.all(5.0),
            content: TextField(
              decoration: const InputDecoration(hintText: "Title"),
              onChanged: (String value) {
                bookTitle = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Add Book"),
                onPressed: () async {
                  if (bookTitle.isNotEmpty) {
                    print('User entered BookTitle: $bookTitle');
                    var title = bookTitle;
                    try {
                      var data = await stockService.getCompanyInfo(title);
                      if (data == null) {
                        print("Call to get Restful API data failed");
                      } else {
                        var resultFirstPublishYear = data['first_publish_year'];
                        print(resultFirstPublishYear);
                        await databaseService.insertBook({
                          'title': data['title'],
                          'author': data['author_name'][0],
                          'first_publish_year': data['first_publish_year'],
                        });
                        bookList = await databaseService.getAllStocksFromDb();
                        databaseService.printAllStocksInDbToConsole();
                        setState(() {});
                      }
                    } catch (e) {
                      print('HomeView inputStock catch: $e');
                    }
                  }
                  bookTitle = "";
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
