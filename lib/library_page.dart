import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minuet_library/components/action_button.dart';
import 'package:minuet_library/components/book.dart';
import 'package:minuet_library/components/sidemenu.dart';
import 'package:minuet_library/login_page.dart';

class BookList extends StatefulWidget {
  @override
  LibraryPage createState() => LibraryPage();
}

class LibraryPage extends State<BookList> {
  List<List<dynamic>> booklist = [];
  int counter = 17;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    var file2 = await rootBundle.loadString('assets/books.csv');
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(file2);
    setState(() {
      booklist = rowsAsListOfValues;
      booklist.removeAt(0); // Hapus baris pertama jika diperlukan
    });
  }

  void removeBook(int id) {
    setState(() {
      booklist.removeWhere((item) => item[0] == id);
    });
  }

  void addBook(String title, String author, String rating, int? status) {
    setState(() {
      counter++;
      booklist.add([counter, title, author, rating, status]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minuet Library',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: Sidemenu(),
      body: booklist.isEmpty
          ? Center(child: Text('Belum ada buku yang ditambahkan'))
          : ListView.builder(
              itemCount: booklist.length,
              itemBuilder: (context, index) {
                final book = booklist[index];
                return Book(
                  id: book[0],
                  title: book[1].toString(),
                  author: book[2].toString(),
                  rating: 'Rating: ${book[3].toString()}',
                  shelves: book[4].toString(),
                  onRemove: removeBook,
                );
              },
            ),
      floatingActionButton: ExampleExpandableFab(onAdd: addBook),
    );
  }
}
