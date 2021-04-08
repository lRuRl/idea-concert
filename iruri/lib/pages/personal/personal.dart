import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
 ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("PERSONAL"),
    );
  }
}
