import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget_demo_page.dart';

class WidgetData {
  final String name;
  final String description;
  final String example;

  WidgetData({
    required this.name,
    required this.description,
    required this.example,
  });

  factory WidgetData.fromJson(Map<String, dynamic> json) {
    return WidgetData(
      name: json['name'],
      description: json['description'],
      example: json['example'],
    );
  }
}

class WidgetCatalogPage extends StatelessWidget {
  Future<List<WidgetData>> loadMockData() async {
    final jsonString = await rootBundle.loadString('assets/widgets.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => WidgetData.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Flutter Widget Catalog')),
      body: FutureBuilder<List<WidgetData>>(
        future: loadMockData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('    error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final widgets = snapshot.data!;
          return ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (context, index) {
              final widgetInfo = widgets[index];
              return Card(
                child: ListTile(
                  title: Text(widgetInfo.name),
                  subtitle: Text(widgetInfo.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WidgetDemoPage(widgetInfo),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
