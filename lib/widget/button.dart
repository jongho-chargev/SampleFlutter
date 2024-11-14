import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sample_gs/main.dart';

class Button extends StatefulWidget {
  Function() ontap;
  Color leftColor;
  Color rightColor;
  String text;
  TextStyle textStyle;
  double height;
  Duration duration;
  Button(
      {super.key,
      required this.ontap,
      this.text = "BUTTON",
      this.height = 50,
      this.duration = const Duration(milliseconds: 300),
      this.textStyle = const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontStyle: FontStyle.italic),
      this.leftColor = const Color.fromRGBO(26, 84, 255, 1),
      this.rightColor = const Color.fromRGBO(215, 2, 251, 1)});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late Function() ontap;
  late Color leftColor;
  late Color rightColor;
  late String text;
  late TextStyle textStyle;
  late double height;
  late Duration duration;
  bool touched = false;
  @override
  void initState() {
    ontap = widget.ontap;
    leftColor = widget.leftColor;
    rightColor = widget.rightColor;
    text = widget.text;
    textStyle = widget.textStyle;
    height = widget.height;
    duration = widget.duration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: ontap,
        onTapDown: (_) => setState(() {
          touched = true;
        }),
        onTapUp: (_) async => Future.delayed(duration, (() {
          touched = false;

          setState(() {});
        })),
        child: AnimatedContainer(
          height: height,
          duration: duration,

          decoration: ShapeDecoration(
              shape: touched
                  ? Border.all(
                      color: Colors.black,
                      width: 18.0,
                    )
                  : Border.all(
                      color: Colors.blue,
                      width: 8.0,
                    )),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     gradient: touched
          //         ? LinearGradient(colors: [leftColor, rightColor])
          //         : LinearGradient(colors: [rightColor, leftColor])),
          child: Text(
            text,
            style: textStyle,
          ).center(),
        ),
      );
    });
  }
}
