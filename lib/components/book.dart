import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final int _id;
  final String _title;
  final String _author;
  final String _rating;
  final String _shelves;

  final Function(int) onRemove;

  const Book(
      {super.key,
      required int id,
      required String title,
      required String author,
      required String rating,
      required String shelves,
      required this.onRemove})
      : _id = id,
        _title = title,
        _author = author,
        _rating = rating,
        _shelves = shelves;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  // Menggunakan Expanded agar bisa memanfaatkan ruang
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Menjaga teks di sisi kiri
                    children: [
                      Text(
                        _title,
                        overflow: TextOverflow
                            .visible, // Ubah overflow menjadi visible
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'by $_author',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  _rating,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  _shelves,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400]),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      print('id: $_id');
                      onRemove(_id);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: const Text(
                      'Hapus',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
