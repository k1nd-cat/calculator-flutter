import 'package:calculator/controller/input_manager.dart';
import 'package:calculator/view/num_pad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _resultStr = '';
  late String _equationStr = '';
  InputManager _inputManager = InputManager();

  void onClick(value) {
    _inputManager.input(value);
    setState(() {
      _equationStr = _inputManager.outputEquation;
      _resultStr = _inputManager.outputResult ?? _resultStr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Color.fromRGBO(200, 160, 80, 1),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20, right: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 50,
                  right: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _equationStr,
                      style: TextStyle(
                        fontSize: 40,
                        color: Color.fromRGBO(200, 160, 80, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, right: 40),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _resultStr,
                      style: TextStyle(
                        color: Color.fromRGBO(200, 160, 80, 1),
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              NumPadGrid(
                buttons: [
                  'C',
                  '(',
                  ')',
                  '/',
                  '1',
                  '2',
                  '3',
                  '*',
                  '4',
                  '5',
                  '6',
                  '-',
                  '7',
                  '8',
                  '9',
                  '+',
                  '.',
                  '0',
                  '^',
                  '=',
                ],
                onClick: onClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
