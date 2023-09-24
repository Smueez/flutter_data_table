import 'package:flutter/material.dart';

import '../utils/responsive_size.dart';


class CustomTextWidgetUI extends StatefulWidget {
  const CustomTextWidgetUI({required this.showLabel, this.textAlign, required this.textStyle, super.key});
  final String? showLabel;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  State<CustomTextWidgetUI> createState() => _CustomTextWidgetUIState();
}

class _CustomTextWidgetUIState extends State<CustomTextWidgetUI> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.showLabel.toString(),
            textAlign: widget.textAlign??TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: widget.textStyle??TextStyle(
                color: Colors.black,
                fontSize: Responsive.pixel(5, context)
            ),
          ),
        ),
      ],
    );
  }
}