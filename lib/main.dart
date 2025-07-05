import 'package:flutter/material.dart';
import 'home.dart';
import 'upload_screen.dart';
import 'detail.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        platform: TargetPlatform.iOS,  // biar feel UI lebih lembut di iOS
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/upload': (context) => UploadScreen(),
      },
      onGenerateRoute: (settings) {
        final path = settings.name?.split('/') ?? [];
        if (path.length > 1 && path[0] == 'detail') {
          final title = path[1];
          // cari buku di list books
          Book book = books.firstWhere((it) => it.title == title);
          return MaterialPageRoute(
            builder: (context) => Detail(book),
          );
        }
        return null;
      },
    );
  }
}
