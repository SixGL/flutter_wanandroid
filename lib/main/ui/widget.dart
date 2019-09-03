import 'package:flutter/material.dart';

class TextWidegt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextState();
  }

  TextWidegt(Key key) : super(key: key);
}

class TextState extends State {
  String tvContent;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("$tvContent");
  }

  void onPressed(int tv) {
    setState(() {
      tvContent = "$tv";
    });
  }
}

typedef OnPressed();

class ButtonWidget extends StatefulWidget {
  OnPressed onPressed;

  ButtonWidget({this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState(onPressed);
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  OnPressed _onPressed;

  _ButtonWidgetState(this._onPressed);

//  GlobalKey<TextState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(
          'count++',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
