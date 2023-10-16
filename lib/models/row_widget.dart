import 'package:flutter/material.dart';
import 'package:flutter_data_table/models/row_field_widget.dart';

import 'checkbox_widget_model.dart';

class RowWidgetModel<T> {
  List<RowFieldWidgetModel> rowFieldList;
  T? others;
  bool rowClickable;
  bool isSelected;
  CheckBoxWidgetStyle? checkBoxWidgetModel;
  Function()? onRowClick;

  RowWidgetModel({
    required this.rowFieldList,
    this.others,
    this.checkBoxWidgetModel,
    this.rowClickable = false,
    this.isSelected = false,
    this.onRowClick
  });
}

class RowColor{
  final Color color1;
  final Color color2;
  RowColor({
    required this.color1,
    required this.color2
});
}