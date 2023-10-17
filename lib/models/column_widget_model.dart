import 'package:flutter/material.dart';
import 'package:flutter_data_table/models/row_field_widget.dart';

import 'checkbox_widget_model.dart';
import 'column_header_model.dart';


/// this is the whole column model
/// this class initializes the column headers along with all info of columns.
class ColumnWidgetModel {
  /// columnsList is a List of ColumnHeaderModel type enum. This is not required.
  /// This is the list where you will put all the column model objects.
  List<ColumnHeaderModel> columnsList;

  /// if sort is enabled. this initialized from table sort availability
  bool isSortable = false;

  // **headerBorderColor** is a **Color**. This is a header border color.
  Color? backgroundColor = Colors.green;
  /// headerBorder is a boolean type field.
  /// This indicates if you want to have border on column header.
  bool headerBorder;

  /// headerBorderColor is a Color. This is a header border color.
  Color? headerBorderColor;

  /// checkBoxWidgetStyle is not required and it only accepts a CheckBoxWidgetStyle.
  /// This gives a style for the checkbox in the multiselect mode.
  CheckBoxWidgetStyle? checkBoxWidgetStyle;

  /// style is a TextStyle.
  TextStyle? style;

  /// constructor
  ColumnWidgetModel({
    required this.columnsList,
    this.checkBoxWidgetStyle,
    this.headerBorder = true,
    this.headerBorderColor,
    this.backgroundColor,
    this.style
  }){
    /// initializing other values
    backgroundColor ??= Colors.green;
    /// checking if sortable
    for(ColumnHeaderModel col in columnsList){
      if(col.columnType == RowFieldWidgetType.editText){
        isSortable = false;
      }
    }
  }

  /// empty constructor
 factory ColumnWidgetModel.empty(){
    return ColumnWidgetModel(columnsList: []);
 }
}