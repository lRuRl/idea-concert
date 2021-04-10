import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
 ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text("Personal"),
        MyProfile(),
      ],)
    );
  }
}