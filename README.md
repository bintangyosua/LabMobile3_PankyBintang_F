# Minuet Library

Tugas Praktikum Mobile 3 <br>

Nama: Panky Bintang Pradana Yosua <br>
NIM: H1D022077 <br>
Shift Baru: F

## Penjelasan Kode

### 1. Halaman Login

`lib/login_page.dart`
Melakukan login. Terdapat dua fields, yaitu username dan password. Jika field kosong, memunculkan validasi handling notifikasi, jika username atau password salah, memunculkan validasi handling notifikasi data salah. Modul SharedPreferences digunakan untuk menyimpan data user yang sign in. Jika user berhasil sign in maka akan diarahkan ke halaman Library.

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
if (_usernameController.text == '' || _passwordController.text == '') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Username dan Password harus diisi!'),
    ),
  );
} else if (_usernameController.text != 'bintang' ||
    _passwordController.text != '123456') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Username atau Password yang anda masukkan salah!'),
    ),
  );
} else {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', _usernameController.text);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => BookList()));
}
```

### 2. Halaman Library

`lib/library_page.dart`
Melihat daftar buku yang disimpan. Terdapat beberapa metadata seperti: judul, author, rating, dan status pembacaan (to read, currently reading, ataupun read). Membaca file csv yang ada pada `assets/books.csv` dengan library `csv`.

```dart
Future<void> loadBooks() async {
  var file2 = await rootBundle.loadString('assets/books.csv');
  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(file2);
  setState(() {
    booklist = rowsAsListOfValues;
    booklist.removeAt(0); // Hapus baris pertama jika diperlukan
  });
}
```

Setelah itu, data csv tersebut ditampilkan.

```dart
ListView.builder(
  itemCount: booklist.length,
  itemBuilder: (context, index) {
    final book = booklist[index];
    return Book(
      id: book[0],
      title: book[1].toString(),
      author: book[2].toString(),
      rating: book[3],
      shelves: book[4],
      onRemove: removeBook,
      onEdit: editBook,
    );
  },
),
```

#### 2.1 Menambah Buku

`lib/components/action_button.dart`
Menambah buku dengan memanfaatkan action button yang ada di pojok kanan bawah. Jika diklik akan memunculkan tombol +, lalu jika diklik akan memunculkan modal. Lalu klik tombil simpan, setelah disimpan, data yang ada pada modal akan direset pada default value.

```dart
actions: [
  TextButton(
    onPressed: () {
      if (_statusController.text == '') {
        _statusController.text = '0';
      }

      widget.onAdd(
        _titleController.text,
        _authorController.text,
        int.parse(_ratingController.text),
        int.parse(_statusController.text),
      );
      Navigator.pop(context);
      _titleController.text = '';
      _authorController.text = '';
      _ratingController.text = '';
      _statusController.text = '';
    },
    child: const Text('Simpan'),
  ),
]
```

#### 2.2 Mengedit Buku

`lib/components/book.dart`
Mengedit data buku. Dilakukan dengan mengklik button Edit di salah satu buku, lalu mengisi data yang ingin diubah.

```dart
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
]
```

#### 2.3 Menghapus Buku

`lib/components/book.dart`
Menghapus buku. Dilakukan dengan mengklik button Hapus di salah satu buku yang ingin dihapus.

```dart
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
```

Kode berikut ada pada `lib/library.page`. Digunakan untuk menyimpan fungsi onRemove untuk menghappus dan onEdit untuk mengedit.

```dart
body: booklist.isEmpty ? const Center(child: Text('Belum ada buku yang ditambahkan')) : ListView.builder(
      itemCount: booklist.length,
      itemBuilder: (context, index) {
        final book = booklist[index];
        return Book(
          id: book[0],
          title: book[1].toString(),
          author: book[2].toString(),
          rating: book[3],
          shelves: book[4],
          onRemove: removeBook,
          onEdit: editBook,
        );
      },
    ),
```

### 3. Sidebar

`lib/components/sidemenu.dart`
Menampilkan sidebar aplikasi. Dilakukan dengan klik button hamburger pada pojok kiri atas. Sidebar ini akan memunculkan informasi user, menu library, profile, dan sign out. Dipasang pada salah satu attribute Scafflod, yaitu `drawer`.

```dart
drawer: const Sidemenu(),
```

Lalu, mendefinisikan route pada `main.dart`.

```dart
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Minuet Library',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      useMaterial3: true,
    ),
    home: const LoginPage(),
    routes: {
      '/library': (context) => BookList(),
      '/profile': (context) => const ProfilePage(),
    },
  );
}
```

Setelah itu menggunakan route tersebut berdasarkan nama

```dart
ListTile(
  leading: const Icon(Icons.home),
  title: const Text('Library'),
  onTap: () {
    Navigator.pushNamed(context, '/library'); // Ini
  },
),
ListTile(
  leading: const Icon(Icons.person),
  title: const Text('Profile'),
  onTap: () {
    Navigator.pushNamed(context, '/profile'); // Ini
}),
```

### 4. Profile

`lib/profile_page.dart`
Menampmilkan profile user dengan memberikan informasi username dari user yang sedang sign in. Dilakukan dengan mengklik salah satu sub menu pada sidebar, yaitu Profile.

Data yang ada pada Storage `SharedPreferences` diambil dengan fungsi di bawah.

```dart
Future<String> getUsername(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username')!;
  return username;
}
```

Setelah itu ditampilkan pada kode di bawah:

```dart
FutureBuilder(
future: getUsername(context),
builder: (context, snapshot) {
  if (snapshot.hasData) {
    return Text(
      '${snapshot.data}',
      style: const TextStyle(fontSize: 32),
    );
  } else {
    return const CircularProgressIndicator();
  }
}),
```

### 5. Sign out

`lib/components/sidemenu.dart`

Melakukan Sign out dari aplikasi. Dilakukan dengan mengklik salah satu sub menu pada sidebar, yaitu Sign out. Proses nya yaitu menghapus string dengan key `username` pada Storage `SharedPreferences`.

```dart
ListTile(
  leading: const Icon(Icons.exit_to_app_rounded),
  title: const Text('Sign out'),
  onTap: () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }),
```

## Demo

![Animated Demo](./assets/gif/animated.gif)
