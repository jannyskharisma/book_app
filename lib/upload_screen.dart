import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'pdf_screen.dart';
import 'data.dart';
import 'detail.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  void pickFile() async {
    // Buka file picker hanya untuk PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      String fileName = result.files.single.name;

      // Cek apakah sudah ada buku dengan judul sama
      bool alreadyExists = books.any((book) => book.title == fileName);

      if (!alreadyExists) {
        // Buat objek Book baru
        final newBook = Book(
          fileName,             // title
          'User',               // writer
          'Free',               // price
          'assets/default_cover.jpg', // default cover
          5.0,                  // rating
          100,                  // pages (dummy)
          description: 'User uploaded book',
          path: path,           // path asli file PDF user
        );

        setState(() {
          books.add(newBook);
        });

        // Langsung buka halaman detail
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(newBook)),
        );
      } else {
        // Jika sudah ada, tampilkan pesan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Buku ini sudah ada di daftar")),
        );
      }
    } else {
      // User batal pilih file
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload PDF")),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: pickFile,
          icon: Icon(Icons.upload_file),
          label: const Text('Select PDF'),
        ),
      ),
    );
  }
}
