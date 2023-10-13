import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'column_header_model.dart';
import 'custom_table_dropdown_model.dart';

/*
options =[
 { "id": 1,
  "label": "item name",
  ...
  you can add more if you want but this 2 is mandatory
  }
  ]
 */

class RowFieldWidgetModel<T> {
  RowFieldWidgetType? type;
  dynamic value;
  List<CustomTableDropDownModel> options;
  // int? order;
  String? columnName = "";
  Function()? onClick;
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
    // this.order,
    // this.columnName,
    required this.columnHeaderModel,
    required this.value,
    this.options = const [],
    this.onClick,
    this.textAlign,
    this.style,
    this.fixedWidth,
    this.other,
    this.onDropDownValueChange,
    this.onEditTextValueChange,
    this.inputType = InputType.string
  }){
    type ??= columnHeaderModel.columnType;
    // order ??= columnHeaderModel.orderNumber;
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