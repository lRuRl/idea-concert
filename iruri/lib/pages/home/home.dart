import 'package:flutter/material.dart';
import 'package:iruri/components/navigation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("HOME"),
    );
  }
}
