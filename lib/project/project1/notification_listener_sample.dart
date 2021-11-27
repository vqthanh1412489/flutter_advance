import 'package:flutter/material.dart';

class NotificationListenerSample extends StatefulWidget {
  const NotificationListenerSample({Key? key}) : super(key: key);

  @override
  State<NotificationListenerSample> createState() =>
      _NotificationListenerSampleState();
}

class _NotificationListenerSampleState
    extends State<NotificationListenerSample> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationListenerSample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('Value'), Text(_counter.toString())],
        ),
      ),
      floatingActionButton: NotificationListener<_NotificationActionButton>(
        onNotification: (details) {
          print('object ${details.value}');
          _incrementCounter();
          return true;
        },
        child: const BackgroundButton(),
      ),
    );
  }
}

class BackgroundButton extends StatelessWidget {
  const BackgroundButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.white])),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ActionButton(),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          _NotificationActionButton().dispatch(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add));
  }
}

class _NotificationActionButton extends Notification {
  int value = 100;
}
