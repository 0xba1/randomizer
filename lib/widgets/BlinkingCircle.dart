import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class BlinkingCircle extends StatefulWidget {
  BlinkingCircle({Key key, @required this.size}) : super(key: key);
  final double size;
  @override
  _BlinkingCircleState createState() => _BlinkingCircleState();
}

class _BlinkingCircleState extends State<BlinkingCircle>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    double size = widget.size;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0, end: size)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut))
          ..addListener(() {
            setState(() {});
          });
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animation.value,
      height: animation.value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
