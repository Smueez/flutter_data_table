import 'package:flutter/material.dart';

import '../models/column_header_model.dart';
import '../utils/responsive_size.dart';

class ColumnHeaderWidgetUI extends StatefulWidget {
  const ColumnHeaderWidgetUI({required this.columnHeaderData, this.headerBorderColor, this.isSortable = false, this.sortedColumn, this.backgroundColor, this.headerBorder = true, this.style,super.key});
  final ColumnHeaderModel columnHeaderData;
  final bool isSortable;
  final String? sortedColumn;
  final Color? backgroundColor;
  final TextStyle? style;
  final bool headerBorder;
  final Color? headerBorderColor;
  @override
  State<ColumnHeaderWidgetUI> createState() => _ColumnHeaderWidgetUIState();
}

class _ColumnHeaderWidgetUIState extends State<ColumnHeaderWidgetUI> {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: Responsive.height(1, context), horizontal: Responsive.height(2, context)),
      decoration: BoxDecoration(
          color: widget.backgroundColor?? Colors.green,
        border: widget.headerBorder? Border(
          right: BorderSide(color: widget.headerBorderColor?? Colors.white)
        ):null
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                widget.columnHeaderData.label.toString(),
                textAlign: widget.columnHeaderData.textAlign?? TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: widget.style??TextStyle(
                  fontSize: Responsive.pixel(5, context),
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            widget.isSortable? Icon(
                Icons.swap_vert,
              color: widget.sortedColumn == widget.columnHeaderData.slug? Colors.black : Colors.white,
              size: Responsive.pixel(5, context),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
