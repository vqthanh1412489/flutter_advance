import 'package:flutter/material.dart';

class DynamicSizeButton extends StatefulWidget {
  const DynamicSizeButton({Key? key}) : super(key: key);

  @override
  _DynamicSizeButtonState createState() => _DynamicSizeButtonState();
}

class _DynamicSizeButtonState extends State<DynamicSizeButton> {
  double _widthSize = 300.0;
  String _text = 'My name: ';

  final _keyText = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      print(
          '_keyText.currentContext?.size ${_keyText.currentContext?.size?.width}');

      if (_keyText.currentContext?.size?.width != null) {
        setState(() {
          _widthSize = _keyText.currentContext!.size!.width + 20.0;
        });
      }
    });
    super.initState();
  }

  void onTab() async {
    print(
        '_keyText.currentContext?.size ${_keyText.currentContext?.size?.width}');
    setState(() {
      _text = 'My name is Thanh';
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _widthSize = _keyText.currentContext!.size!.width + 20.0 + 80.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DynamicSizeButton'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: onTab, child: const Text('Chaneg text')),
              AnimatedContainer(
                width: _widthSize,
                height: 50,
                color: Colors.blue,
                // padding: const EdgeInsets.all(10.0),
                duration: const Duration(seconds: 1),
                child: Center(
                    child: Text(
                  _text,
                  key: _keyText,
                )),
              )
            ],
          ),
        ));
  }
}
