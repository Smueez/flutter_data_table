import 'package:flutter/material.dart';

import '../models/column_header_model.dart';
import '../utils/responsive_size.dart';


/// this is the ui for each column header
class ColumnHeaderWidgetUI extends StatefulWidget {
  const ColumnHeaderWidgetUI({required this.columnHeaderData, this.headerBorderColor, this.isSortable = false, this.sortedColumn, this.backgroundColor, this.headerBorder = true, this.style,super.key});
  /// this ColumnHeaderModel
  /// This is the actual data of the columns
  final ColumnHeaderModel columnHeaderData;

  /// boolean if the column sortable
  final bool isSortable;

  /// last sorted column name
  final String? sortedColumn;

  /// column background color
  final Color? backgroundColor;

  /// this is the text style
  final TextStyle? style;

  /// header border enable flag
  final bool headerBorder;

  /// this the border color
  final Color? headerBorderColor;
  @override
  State<ColumnHeaderWidgetUI> createState() => _ColumnHeaderWidgetUIState();
}

class _ColumnHeaderWidgetUIState extends State<ColumnHeaderWidgetUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /// padding
      padding: EdgeInsets.symmetric(vertical: FlutterDataTableResponsive.height(1, context), horizontal: FlutterDataTableResponsive.height(2, context)),
      ///decoration for each column header
      /// color
      /// border decoration
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
              /// this is the header label
              /// text align
              /// and style
              /// the text overflow is ellipsis
              child: Text(
                widget.columnHeaderData.label.toString(),
                textAlign: widget.columnHeaderData.textAlign?? TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: widget.style??TextStyle(
                  fontSize: FlutterDataTableResponsive.pixel(5, context),
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            /// if sorted then a sort icon added beside the header label
            widget.isSortable? Icon(
                Icons.swap_vert,
              color: widget.sortedColumn == widget.columnHeaderData.slug? Colors.black : Colors.white,
              size: FlutterDataTableResponsive.pixel(5, context),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
