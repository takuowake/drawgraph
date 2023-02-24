import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/graph_painter.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: const Text('graph'),
      ),
      body: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: GraphPainter()
      ),
    );
  }
}