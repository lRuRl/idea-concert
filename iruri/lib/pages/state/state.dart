import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("STATE"),
    );
  }
}
