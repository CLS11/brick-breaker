import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';

void main() {
  runApp(BrickBreaker());
}

class BrickBreaker extends StatelessWidget {
  const BrickBreaker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: HomePage(),
    );
  }
}
