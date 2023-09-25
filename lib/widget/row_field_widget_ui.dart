import 'package:flutter/cupertino.dart';
import '../models/row_field_widget.dart';
import 'custom_clickable_wiget_ui.dart';
import 'custom_dropdown_widget_ui.dart';
import 'custom_edit_text_widget_ui.dart';
import 'custom_text_widget_ui.dart';

class RowFieldWidget extends StatefulWidget {
  const RowFieldWidget({required this.rowFieldWidgetModel, super.key});
  final RowFieldWidgetModel rowFieldWidgetModel;

  @override
  State<RowFieldWidget> createState() => _RowFieldWidgetState();
}

class _RowFieldWidgetState extends State<RowFieldWidget> {
  @override
  Widget build(BuildContext context) {
    switch(widget.rowFieldWidgetModel.type){
      case RowFieldWidgetType.textWidget:
        return CustomTextWidgetUI(
            showLabel: widget.rowFieldWidgetModel.value == null? "-": widget.rowFieldWidgetModel.value.toString(),
            textAlign: widget.rowFieldWidgetModel.textAlign,
            textStyle: widget.rowFieldWidgetModel.style);
      case RowFieldWidgetType.currency:
        return CustomTextWidgetUI(
            showLabel: widget.rowFieldWidgetModel.value == null? "\$ 0": "\$ ${widget.rowFieldWidgetModel.value.toString()}",
            textStyle: widget.rowFieldWidgetModel.style);
      case RowFieldWidgetType.editText:
        return CustomEditTextWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel);
      case RowFieldWidgetType.dropdown:
        return CustomDropDownWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel,);
      case RowFieldWidgetType.clickable:
        return CustomClickableWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel);
      case RowFieldWidgetType.customWidget:
        return widget.rowFieldWidgetModel.value is Widget? widget.rowFieldWidgetModel.value: const CustomTextWidgetUI(showLabel: "Empty Data", textStyle: TextStyle(),);
      default:
        return const SizedBox();
    }
  }
}
