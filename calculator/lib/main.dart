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
      // title: 'Flutter Demo',
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

  void nothing(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: TextStyle(
              color: Color.fromRGBO(200, 160, 80, 1),
            ),
        ),
      ),
      body: Center(

        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: NumPadGrid(
              buttons: [
                'C', '(', ')', '/',
                '1', '2', '3', '*',
                '4', '5', '6', '-',
                '7', '8', '9', '+',
                '.', '0', '^', '=',
              ],
              onClick: (String value) {  },
            ),
          ),
        ),

        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     NumPadButton(
        //       value: '9',
        //       onClick: nothing,
        //     ),
        //     NumPadButton(
        //       value: '8',
        //       onClick: nothing,
        //     ),
        //     NumPadButton(
        //       value: '7',
        //       onClick: nothing,
        //     ),
        //     NumPadButton(
        //       value: '*',
        //       onClick: nothing,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
