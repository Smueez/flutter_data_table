import 'package:flutter/material.dart';

import '../utils/responsive_size.dart';

/// this is a plain read only text widget for each cell
class CustomTextWidgetUI extends StatefulWidget {
  const CustomTextWidgetUI({required this.showLabel, this.textAlign, required this.textStyle, super.key});

  /// it takes a label string
  final String? showLabel;
  /// this is a text style
  final TextStyle? textStyle;

  /// this the text align
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
            widget.showLabel.toString(), /// showing text label
            textAlign: widget.textAlign??TextAlign.center,
            overflow: TextOverflow.ellipsis,
            /// giving style of the text widget
            style: widget.textStyle??TextStyle(
                color: Colors.black,
                fontSize: FlutterDataTableResponsive.pixel(5, context)
            ),
          ),
        ),
      ],
    );
  }
}