import 'dart:ui';

import 'package:flutter_data_table/models/row_field_widget.dart';



class ColumnHeaderModel<T>{
  final int id;
  final String slug;
  final String label;
  final int sortOrder;
  final RowFieldWidgetType columnType;
  final double? fixedWidth;
  final TextAlign? textAlign;
  final T? otherData;

  ColumnHeaderModel({
    required this.id,
    required this.slug,
    required this.label,
    required this.sortOrder,
    this.textAlign,
    this.fixedWidth,
    this.columnType = RowFieldWidgetType.textWidget,
    this.otherData
  });

  factory ColumnHeaderModel.empty(){
    return ColumnHeaderModel(id: -1, slug: "", label: "", sortOrder: -1);
  }
}