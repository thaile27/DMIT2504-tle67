// ignore_for_file: todo, avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls, file_names, unused_import

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      //TODO: Put your code here to complete this method.
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'Books.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE Books (title TEXT PRIMARY KEY, author TEXT, first_publish_year INT)",
          );
        },
        version: 1,
      );
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllBooksInDbToConsole() async {
    try {
      //TODO: Put your code here to complete this method.
      List<Map<String, dynamic>> bookList = await getAllBooksFromDb();
      if (bookList.isEmpty) {
        print('No records in the database');
      } else {
        for (var book in bookList) {
          print(
              'Title: ${book['title']}, Author: ${book['author']}, First Release Year: ${book['first_publish_year']})');
        }
      }
    } catch (e) {
      print('SQFliteDbService printAllBooksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllBooksFromDb() async {
    try {
      //TODO: Put your code here to complete this method.
      // Replace this return with valid data.
      final List<Map<String, dynamic>> books = await db.query('Books');
      return books;
    } catch (e) {
      print('SQFliteDbService getAllBooksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      //TODO: Put your code here to implement this method.
      await sqflitePackage.deleteDatabase(path);
      print('Db deleted');
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertBook(Map<String, dynamic> book) async {
    try {
      //TODO:
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table.
      //Also specify the conflictAlgorithm.
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.

      await db.insert(
        'Books',
        book,
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateBook(Map<String, dynamic> book) async {
    try {
      //TODO:
      //Put code here to update stock info.
      await db.update(
        'Books',
        book,
        where: 'title = ?',
        whereArgs: [book['title']],
      );
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteBook(Map<String, dynamic> book) async {
    try {
      //TODO:
      //Put code here to delete a stock from the database.
      await db.delete(
        'Books',
        where: 'title = ?',
        whereArgs: [book['title']],
      );
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
