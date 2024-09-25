import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  final int id;
  final String title;
  final String author;
  final int rating;
  int? shelves;

  final _shelves = <String>[
    'to read',
    'currently reading',
    'read',
  ];

  final Function(int, String, String, int, int?) onEdit;
  final Function(int) onRemove;

  Book(
      {super.key,
      required this.id,
      required this.title,
      required this.author,
      required this.rating,
      required this.shelves,
      required this.onEdit,
      required this.onRemove});

  @override
  State<Book> createState() => _BookState();
}

@override
class _BookState extends State<Book> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _authorController.text = widget.author;
    _ratingController.text = widget.rating.toString();
    _statusController.text = widget.shelves.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _ratingController.dispose();
    _statusController.dispose();
    super.dispose();
  }

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
                        widget.title,
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
                  'by ${widget.author}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'My Rating ',
                      style: Theme.of(context).textTheme.bodyLarge),
                  for (int i = 0; i < widget.rating; i++)
                    WidgetSpan(
                        child: Icon(Icons.star,
                            size: 20,
                            color:
                                i < 5 ? Colors.amber[600] : Colors.grey[400])),
                  for (int i = widget.rating; i < 5; i++)
                    WidgetSpan(
                        child: Icon(Icons.star_border,
                            size: 20, color: Colors.grey[400]))
                ]))
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  widget._shelves[widget.shelves!],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      _showAction(context, widget.id);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400]),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onRemove(widget.id);
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

  void _showAction(BuildContext context, int id) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Buku',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Judul',
                    prefixIcon: Icon(Icons.title)),
                controller: _titleController,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Author',
                    prefixIcon: Icon(Icons.person)),
                controller: _authorController,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rating',
                    prefixIcon: Icon(Icons.rate_review)),
                controller: _ratingController,
              ),
              const SizedBox(
                height: 12,
              ),
              DropdownButtonFormField<int>(
                value: int.parse(_statusController.text),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                    prefixIcon: Icon(Icons.book)),
                items: const [
                  DropdownMenuItem(value: 0, child: Text("to read")),
                  DropdownMenuItem(value: 1, child: Text("currently reading")),
                  DropdownMenuItem(value: 2, child: Text("read")),
                ],
                onChanged: (int? value) {
                  setState(() {
                    _statusController.text = value.toString();
                  });
                },
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onEdit(
                    widget.id,
                    _titleController.text,
                    _authorController.text,
                    int.parse(_ratingController.text),
                    int.parse(_statusController.text));
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
