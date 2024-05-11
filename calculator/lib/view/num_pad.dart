import 'package:flutter/material.dart';

class NumPadGrid extends StatelessWidget {
  final List<String> buttons;
  final Function(String value) onClick;
  final String _value = '<';

  NumPadGrid({required List<String> buttons, required Function(String value) onClick})
      : this.buttons = buttons,
        this.onClick = onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: RawMaterialButton(
                onPressed: () => onClick(_value),
                elevation: 0,
                fillColor: Color(0x44000000),
                child: Center(
                    child: Icon(Icons.backspace,
                      color: Color.fromRGBO(200, 160, 80, 1),
                    )
                ),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
            ),
          ]
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Divider(
            height: 12,
            thickness: 1.5,
            // indent: 18,
            // endIndent: 18,
            color: Color.fromRGBO(75, 75, 75, 1),
          ),
        ),
        Table(
            children: List.generate(5, (rowIndex) {
              return TableRow(
                children: List.generate(4, (colIndex) {
                  int buttonIndex = rowIndex * 4 + colIndex;
                  if (buttonIndex < buttons.length) {
                    return NumPadButton(
                      value: buttons[buttonIndex],
                      onClick: onClick,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              );
            }
          ),
        ),
      ]
    );
  }
}

class NumPadButton extends StatelessWidget {
  final String _value;
  final String _text;
  final Function(String value) _onClick;
  static final Map<String, String> _values = {
    '+': '+',
    '-': '-',
    '*': '×',
    '/': '⨫',
    '^': 'x^'
  };

  NumPadButton({required String value, required Function(String value) onClick})
    : _value = value,
      _onClick = onClick,
      _text = _values[value] ?? value;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: RawMaterialButton(
        onPressed: () => _onClick(_value),
        elevation: 0,
        fillColor: Color.fromRGBO(30, 30, 30, 1),
        child: Center(
          child: Text(_text,
            style: TextStyle(
              fontSize: 30,
              // backgroundColor: Color.fromRGBO(200, 160, 80, 1),
              color: Color.fromRGBO(200, 160, 80, 1),
            ),
          ),
        ),
        padding: EdgeInsets.all(18.0),
        shape: CircleBorder(),
      ),
    );
  }
}