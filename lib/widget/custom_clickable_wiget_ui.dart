import 'package:flutter/material.dart';

import '../models/row_field_widget.dart';
import '../utils/responsive_size.dart';

/// this is the clickable widget
class CustomClickableWidgetUI extends StatefulWidget {
  CustomClickableWidgetUI({required this.rowFieldWidgetModel, super.key});
  /// it takes only one parameter rowFieldWidgetModel
  /// which is RowFieldWidgetModel
  RowFieldWidgetModel rowFieldWidgetModel;
  @override
  State<CustomClickableWidgetUI> createState() => _CustomClickableWidgetUIState();
}

class _CustomClickableWidgetUIState extends State<CustomClickableWidgetUI> {
  @override
  Widget build(BuildContext context) {
    /// used InWell to get the on tap functionality
    return InkWell(
      /// on tap function
      onTap: widget.rowFieldWidgetModel.onRowFieldClick,
      child: Center(
        /// showing the label
        /// style of the label
        child: Text(
          widget.rowFieldWidgetModel.value.toString(),
          textAlign: TextAlign.center,
          style: widget.rowFieldWidgetModel.style??TextStyle(
            color: Colors.blue,
            fontSize: FlutterDataTableResponsive.pixel(5, context),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
