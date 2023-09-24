import 'package:flutter/material.dart';

import '../models/row_field_widget.dart';
import '../utils/responsive_size.dart';

class CustomClickableWidgetUI extends StatefulWidget {
  CustomClickableWidgetUI({required this.rowFieldWidgetModel, super.key});
  RowFieldWidgetModel rowFieldWidgetModel;
  @override
  State<CustomClickableWidgetUI> createState() => _CustomClickableWidgetUIState();
}

class _CustomClickableWidgetUIState extends State<CustomClickableWidgetUI> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.rowFieldWidgetModel.onClick,
      child: Center(
        child: Text(
          widget.rowFieldWidgetModel.value.toString(),
          textAlign: TextAlign.center,
          style: widget.rowFieldWidgetModel.style??TextStyle(
            color: Colors.blue,
            fontSize: Responsive.pixel(5, context),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
