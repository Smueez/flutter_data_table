import 'package:flutter/material.dart';
import 'package:flutter_data_table/models/row_field_widget.dart';

import 'checkbox_widget_model.dart';
import 'column_header_model.dart';

class ColumnWidgetModel {
  List<ColumnHeaderModel> columnsList;
  bool isSortable;
  String Function([dynamic params])? onSort;
  Color? backgroundColor = Colors.green;
  bool headerBorder;
  Color? headerBorderColor;
  CheckBoxWidgetModel? checkBoxWidgetModel;
  TextStyle? style;

  ColumnWidgetModel({
    required this.columnsList,
    this.checkBoxWidgetModel,
    this.isSortable = false,
    this.onSort,
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