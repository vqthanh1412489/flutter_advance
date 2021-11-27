import 'package:flutter/material.dart';

class App3 extends StatelessWidget {
  const App3({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Center(
        child: Text('Project3'),
      ),
    );
  }
}
