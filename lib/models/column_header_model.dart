import 'dart:ui';

import 'package:flutter_data_table/models/row_field_widget.dart';



class ColumnHeaderModel<T>{
  final int? id;
  final String slug;
  final String label;
  int orderNumber;
  final RowFieldWidgetType columnType;
  final double? fixedWidth;
  final TextAlign? textAlign;
  final T? otherData;

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

  factory ColumnHeaderModel.empty(){
    return ColumnHeaderModel(id: -1, slug: "", label: "", orderNumber: -1);
  }
}