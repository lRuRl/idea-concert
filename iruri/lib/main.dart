import 'package:flutter/material.dart';
// routes
import 'package:iruri/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 우측 상단에 DEBUG 표시 제거
      debugShowCheckedModeBanner: false,
      home: Routes(),
    );
  }
}
