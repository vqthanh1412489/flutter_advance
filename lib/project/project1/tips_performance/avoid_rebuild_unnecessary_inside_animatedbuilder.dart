import 'dart:math';

import 'package:flutter/material.dart';

class AvoidRebuildWidgetInsideAnimatedBuilder extends StatefulWidget {
  const AvoidRebuildWidgetInsideAnimatedBuilder({Key? key}) : super(key: key);

  @override
  _AvoidRebuildWidgetInsideAnimatedBuilderState createState() =>
      _AvoidRebuildWidgetInsideAnimatedBuilderState();
}

class _AvoidRebuildWidgetInsideAnimatedBuilderState
    extends State<AvoidRebuildWidgetInsideAnimatedBuilder>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  int counter = 0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onPress() {
    setState(() {
      counter++;
    });
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AvoidRebuildWidgetInsideAnimatedBuilder'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        splashColor: Colors.red,
        child: const Icon(Icons.slow_motion_video),
      ),
      body: AnimatedBuilder(
          animation: animationController,
          child: CounterWidget(counter: counter), // Tip: Init Widget
          builder: (_, child4) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(360 * animationController.value * (pi / 180.0)),
              child: child4, // Tip: and use Widget here.
            );
          }),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key? key,
    required this.counter,
  }) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    print('re-render CounterWidget');
    return Center(
      child: Text(
        counter.toString(),
        style: const TextStyle(fontSize: 50, color: Colors.blue),
      ),
    );
  }
}
