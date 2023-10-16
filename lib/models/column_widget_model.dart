import 'package:flutter/material.dart';
import 'package:flutter_data_table/models/row_field_widget.dart';

import 'checkbox_widget_model.dart';
import 'column_header_model.dart';

class ColumnWidgetModel {
  List<ColumnHeaderModel> columnsList;
  bool isSortable = false;
  Color? backgroundColor = Colors.green;
  bool headerBorder;
  Color? headerBorderColor;
  CheckBoxWidgetStyle? checkBoxWidgetStyle;
  TextStyle? style;

  ColumnWidgetModel({
    required this.columnsList,
    this.checkBoxWidgetStyle,
    this.headerBorder = true,
    this.headerBorderColor,
    this.backgroundColor,
    this.style
  }){
    backgroundColor ??= Colors.green;
    for(ColumnHeaderModel col in columnsList){
      if(col.columnType == RowFieldWidgetType.editText){
        isSortable = false;
      }
    }
  }

 factory ColumnWidgetModel.empty(){
    return ColumnWidgetModel(columnsList: []);
 }
}