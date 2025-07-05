import 'package:flutter/material.dart';
import 'package:flutter_book_app_new/data.dart';
import 'upload_screen.dart';
import 'detail.dart';
import 'pdf_screen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      leading: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'upload') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadScreen()),
            ).then((_) {
              setState(() {}); // force rebuild saat balik dari upload
            });
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 'upload', child: Text('Upload PDF')),
        ],
      ),
      title: Text('Design Books'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );

    // 🟢 drawer upload
    final drawer = Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Menu')),
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text('Upload PDF'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadScreen()));
            },
          ),
        ],
      ),
    );

    createTile(Book book) => Hero(
          tag: book.title,
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.yellow.shade900,
            child: InkWell(
              onTap: () {
                if (book.path != null && book.path!.isNotEmpty) {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Detail(book)));
                } else {
                  Navigator.pushNamed(context, 'detail/${book.title}');
                }
              },
              child: Image(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

    final grid = CustomScrollView(
      primary: false,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: books.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      drawer: drawer,
      body: grid,
    );
  }
}
