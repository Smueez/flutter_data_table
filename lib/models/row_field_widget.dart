import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'column_header_model.dart';
import 'custom_table_dropdown_model.dart';
/// This is the constructor of RowFieldWidgetModel<T>. Here T is the Generic Type. Each RowFieldWidgetModel is the the cell of each row.
class RowFieldWidgetModel<T> {
  /// type is a RowFieldWidgetType type enum. 
  /// This is not required. This field is initialized by the ColumnHeaderWidget. 
  /// So you can ignore it when building row widgets.
  RowFieldWidgetType? type;
  
  /// value is a dynamic type field.
  /// This required field accepts all kind of data type including
  /// Int, Double, String, DateTime 
  /// when the cell is text widget or clickable widget or edit text widget.
  /// The Sort function mentioned above works according to this value.
  /// Again this value can be CustomTableDropDownModel<T> if the cell is dropdown type.
  /// value can also be any Widget type is the cell is custom widget type.
  /// These cell is based on it's column header's columnType.
  dynamic value;
  
  /// dropDownOptionsList is a List of CustomTableDropDownModel. 
  /// This is required when the field or cell is dropdown type.
  List<CustomTableDropDownModel> dropDownOptionsList;

  /// this is the corresponding column name
  String? columnName;

  /// onRowFieldClick is a Function.
  /// If the type of the field or cell is "Clickable",
  /// then this function is called on when user click on the field or cell.
  Function()? onRowFieldClick;

  /// other is a Generic Type.
  /// This field for if anyone wants to put some other information about this field to use it later.
  /// You may put any type of data here. All you need is just to put the Generic Data type when initializing the widget.
  T? other;

  /// onDropDownValueChange is a Function.
  /// This function is used when the field or cell is Dropdown type.
  /// This function has 2 parameter. One is CustomTableDropDownModel<T> this is the selected value.
  /// And another one is RowFieldWidgetModel<T> type, which is the particular field or cell model object.
  Function(CustomTableDropDownModel<T>, RowFieldWidgetModel<T>)? onDropDownValueChange;

  /// onEditTextValueChange is also a Function.
  /// Which is used when the field or the cell is a EditText type.
  /// This function also has 2 parameter.
  /// One is String type, which is the updated String value which is written in the edit text field and
  /// another one is the another one is RowFieldWidgetModel<T> type, which is the particular field or cell model object.
  Function(String value, RowFieldWidgetModel<T>)? onEditTextValueChange;

  /// style is a TextStyle type value an it's not required as well.
  /// This gives a style of you text typed field or cell.
  TextStyle? style;

  /// inputType is a InputType type.
  /// This is used when the particular field or cell is EditText type.
  /// This indicates if the input type of the edit text field.
  InputType? inputType;

  /// fixedWidth is a double type. This provides the cell a fixed width.
  double? fixedWidth;

  /// textAlign is a TextAlign type value. This field not required. ColumnHeaderModel will initialize it.
  TextAlign? textAlign;
  
  /// columnHeaderModel is also required and it only accepts a ColumnHeaderModel. 
  /// This should the same column header model object on which the particular cell this under.
  ColumnHeaderModel columnHeaderModel;

  /// constructor
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
    /// initializing other data from column model
    type ??= columnHeaderModel.columnType;
    columnName ??= columnHeaderModel.slug;
    fixedWidth ??= columnHeaderModel.fixedWidth;
    textAlign ??= columnHeaderModel.textAlign;
  }

  /// empty row
  factory RowFieldWidgetModel.empty(){
    return RowFieldWidgetModel(type: RowFieldWidgetType.empty,  value: "", columnHeaderModel: ColumnHeaderModel.empty()); //  order: -1,
  }
}
/// enums
enum RowFieldWidgetType {textWidget, editText, dropdown, clickable, currency, customWidget, empty}
enum InputType {string, number}