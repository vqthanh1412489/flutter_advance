import 'dart:math';

import 'package:flutter/material.dart';

class PreventRebuildAllWidgets extends StatefulWidget {
  const PreventRebuildAllWidgets({Key? key}) : super(key: key);

  @override
  _PreventRebuildAllWidgetsState createState() =>
      _PreventRebuildAllWidgetsState();
}

class _PreventRebuildAllWidgetsState extends State<PreventRebuildAllWidgets> {
  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.blue
  ];
  Random random = Random();
  int index = 0;

  final myText = ValueNotifier(DateTime.now().toString());

  @override
  void initState() {
    super.initState();
  }

  void changeIndex() {
    // setState(() => index = random.nextInt(3));
    myText.value = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreventRebuildAllWidgets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'When click butotn => rebuild time AND not rebuld Container with Ramdom color '),
            const SizedBox(
              height: 200,
            ),
            ValueListenableBuilder<String>(
              builder: (BuildContext context, value, Widget? child) {
                return Text(value.toString());
              },
              valueListenable: myText,
            ),
            Container(
              width: 100,
              height: 100,
              color: colors[index],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeIndex,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
