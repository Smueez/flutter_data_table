import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'column_header_model.dart';
import 'custom_table_dropdown_model.dart';

class RowFieldWidgetModel<T> {
  RowFieldWidgetType? type;
  dynamic value;
  List<CustomTableDropDownModel> dropDownOptionsList;
  String? columnName;
  Function()? onRowFieldClick;
  T? other;
  Function(CustomTableDropDownModel<T>, RowFieldWidgetModel<T>)? onDropDownValueChange;
  Function(String value, RowFieldWidgetModel<T>)? onEditTextValueChange;
  TextStyle? style;
  InputType? inputType;
  double? fixedWidth;
  TextAlign? textAlign;
  ColumnHeaderModel columnHeaderModel;

  RowFieldWidgetModel({
    this.type,
    required this.columnHeaderModel,
    required this.value,
    this.dropDownOptionsList = const [],
    this.onRowFieldClick,
    this.textAlign,
    this.style,
    this.other,
    this.onDropDownValueChange,
    this.onEditTextValueChange,
    this.inputType = InputType.string
  }){
    type ??= columnHeaderModel.columnType;
    columnName ??= columnHeaderModel.slug;
    fixedWidth ??= columnHeaderModel.fixedWidth;
    textAlign ??= columnHeaderModel.textAlign;
  }

  factory RowFieldWidgetModel.empty(){
    return RowFieldWidgetModel(type: RowFieldWidgetType.empty,  value: "", columnHeaderModel: ColumnHeaderModel.empty()); //  order: -1,
  }
}

enum RowFieldWidgetType {textWidget, editText, dropdown, clickable, currency, customWidget, empty}
enum InputType {string, number}