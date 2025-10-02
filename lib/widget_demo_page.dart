import 'package:flutter/material.dart';
import 'widget_catalog_page.dart';

class WidgetDemoPage extends StatefulWidget {
  final WidgetData widgetInfo;

  WidgetDemoPage(this.widgetInfo);

  @override
  _WidgetDemoPageState createState() => _WidgetDemoPageState();
}

class _WidgetDemoPageState extends State<WidgetDemoPage> {
  bool showFirst = true;
  bool isTriangle = true;

  @override
  Widget build(BuildContext context) {
    Widget? liveDemo;

    if (widget.widgetInfo.name == 'AnimatedCrossFade') {
      liveDemo = GestureDetector(
        onTap: () {
          setState(() {
            showFirst = !showFirst;
          });
        },
        child: AnimatedCrossFade(
          duration: Duration(seconds: 1),
          firstChild: Container(width: 100, height: 100, color: Colors.red),
          secondChild: Container(width: 100, height: 100, color: Colors.blue),
          crossFadeState: showFirst
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      );
    } else if (widget.widgetInfo.name == 'ClipPath') {
      liveDemo = GestureDetector(
        onTap: () {
          setState(() {
            isTriangle = !isTriangle;
          });
        },
        child: ClipPath(
          clipper: isTriangle ? TriangleClipper() : CircleClipper(),
          child: Container(width: 150, height: 150, color: Colors.orange),
        ),
      );
    } else if (widget.widgetInfo.name == 'DraggableScrollableSheet') {
      liveDemo = SizedBox(
        height: 300,
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item ${index + 1}'));
                },
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.widgetInfo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.widgetInfo.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Example:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(widget.widgetInfo.example),
            SizedBox(height: 30),
            if (liveDemo != null) liveDemo,
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
