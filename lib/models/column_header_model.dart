import 'dart:ui';

import 'package:flutter_data_table/models/row_field_widget.dart';


/// this is the each column header cell model class with Generic type T
class ColumnHeaderModel<T>{

  /// id
  final int? id;

  /// slug
  final String slug;
  /// label
  final String label;

  /// orderNumber
  int orderNumber;

  /// columnType
  final RowFieldWidgetType columnType;

  /// fixedWidth
  final double? fixedWidth;

  /// textAlign
  final TextAlign? textAlign;

  /// otherData with generic type T
  final T? otherData;

  /// constuctor
  ColumnHeaderModel({
    this.id,
    required this.slug,
    required this.label,
    this.orderNumber = -1,
    this.textAlign,
    this.fixedWidth,
    this.columnType = RowFieldWidgetType.textWidget,
    this.otherData
  });

  /// empty constructor
  factory ColumnHeaderModel.empty(){
    return ColumnHeaderModel(id: -1, slug: "", label: "", orderNumber: -1);
  }
}