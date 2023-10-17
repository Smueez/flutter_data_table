import 'package:flutter/material.dart';
import 'package:flutter_data_table/models/row_field_widget.dart';

import 'checkbox_widget_model.dart';
/// This is the class RowWidgetModel<T>. 
/// Here T is the Generic Type. Each RowWidgetModel is the the each Row of the table.
/// This is the single row
class RowWidgetModel<T> {
  /// rowFieldList is a List of RowFieldWidgetModel. 
  /// This is a required field. This field indicates the list of row cell for a single row.
  List<RowFieldWidgetModel> rowFieldList;
  
  /// other is a Generic Type. 
  /// if anyone wants to put some other information about this row to use it later,
  /// he/she may put any type of data here. All you need is just to put the Generic Data type when initializing the widget.
  T? others;
  
  /// rowClickable is a boolean type field.
  /// If you want to make your row clickable, then make this field "true". 
  /// This field is "false" by default.
  bool rowClickable;
  
  /// check if the row is selected
  bool isSelected = false;
  
  /// checkBoxWidgetStyle is a CheckBoxWidgetStyle type. If the multiselect mode is enabled then this field is for the style of the checkbox.
  CheckBoxWidgetStyle? checkBoxWidgetStyle;
  
  /// onRowClick is a Function. this function is called when the particular row is tapped.
  Function()? onRowClick;

  /// constructor
  RowWidgetModel({
    required this.rowFieldList,
    this.others,
    this.checkBoxWidgetStyle,
    this.rowClickable = false,
    this.onRowClick
  });
}
/// row color for the each row
/// there are 2 colors
class RowColor{
  final Color color1;
  final Color color2;
  RowColor({
    required this.color1,
    required this.color2
});
}