import 'package:flutter/material.dart';
import 'widget_catalog_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Flutter Widget Catalog',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: WidgetCatalogPage(),
    );
  }
}
