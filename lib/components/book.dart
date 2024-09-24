import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String _title;
  final String _author;
  final String _rating;
  final String _shelves;

  const Book(
      {super.key,
      required String title,
      required String author,
      required String rating,
      required String shelves})
      : _title = title,
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
          ],
        ),
      ),
    );
  }
}
