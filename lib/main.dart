import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_charts/chart.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  build(BuildContext context) => new MaterialApp(
        home: new HomePage(),
      );
}

class HomePage extends StatefulWidget {
  @override
  createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final random = new Random();

  AnimationController animation;
  BarTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = new BarTween(new Bar(0.0),new Bar(100.0));
    animation.forward();
  }

  void changeData() => setState(() {
        tween = new BarTween(
          tween.evaluate(animation),
          new Bar(random.nextDouble()*100),
        );
        animation.forward(from: 0.0);
      });

  @override
  build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('Charts'),
        ),
        body: new Center(
          child: new CustomPaint(
            size: new Size(300.0, 200.0),
            painter: new ChartPainter(tween.animate(animation)),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.refresh),
          onPressed: changeData,
        ),
      );

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }
}
