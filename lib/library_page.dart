import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minuet_library/components/book.dart';
import 'package:minuet_library/components/sidemenu.dart';
import 'package:minuet_library/login_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minuet Library',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      drawer: Sidemenu(),
      body: FutureBuilder<List<List<dynamic>>>(
        future: getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books found.'));
          }

          final books = snapshot.data!;

          books.removeAt(0);

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Book(
                title: book[1].toString(),
                author: book[2].toString(),
                rating: 'Rating: ${book[3].toString()}',
                shelves: book[4].toString(),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<List<dynamic>>> getBooks() async {
    var file2 = await rootBundle.loadString('assets/books.csv');
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(file2);

    return rowsAsListOfValues;
  }
}
