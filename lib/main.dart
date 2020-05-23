import 'package:flutter/material.dart';
import 'package:torchler/torch_light.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TorchlerPage(),
    );
  }
}