import 'package:flutter/material.dart';

class ListViewPerformance extends StatefulWidget {
  const ListViewPerformance({Key? key}) : super(key: key);

  @override
  _ListViewPerformanceState createState() => _ListViewPerformanceState();
}

class _ListViewPerformanceState extends State<ListViewPerformance> {
  final List<Widget> widgets = List.generate(
      1000,
      (index) => Container(
            height: 200,
            color: Colors.primaries[index % Colors.primaries.length],
            child: ListTile(
              title: Text('index: $index'),
            ),
          ));

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void scrollToEnd() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListViewPerformance'),
      ),
      body: ListView(
        controller: scrollController,
        children: widgets,
        itemExtent: 200, // Tip 1: Set hight for item by itemExtent.
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scrollToEnd,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
