import 'package:flutter/material.dart';

class NumericStepFormField extends StatefulWidget {
  const NumericStepFormField(
      {Key key, @required this.onChange, this.minValue, this.initValue})
      : super(key: key);
  final onChange;
  final initValue;
  final minValue;
  @override
  _NumericStepFormFieldState createState() => _NumericStepFormFieldState();
}

class _NumericStepFormFieldState extends State<NumericStepFormField> {
  int _value;

  @override
  void initState() {
    _value = widget.initValue ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove,
                size: 20,
                color: Colors.blue,
              ),
              onPressed: () {
                if (_value > widget.minValue ?? widget.initValue ?? 0) {
                  setState(() {
                    _value--;
                  });
                  widget.onChange(_value);
                }
              }),
          SizedBox(
              width: 100,
              height: 20,
              child: Center(
                child: Text("$_value"),
              )),
          IconButton(
              icon: Icon(
                Icons.add,
                size: 20,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  _value++;
                });
                widget.onChange(_value);
              }),
        ],
      ),
    );
  }
}
