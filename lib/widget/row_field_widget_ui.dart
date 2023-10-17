import 'package:flutter/cupertino.dart';
import '../models/row_field_widget.dart';
import 'custom_clickable_wiget_ui.dart';
import 'custom_dropdown_widget_ui.dart';
import 'custom_edit_text_widget_ui.dart';
import 'custom_text_widget_ui.dart';


/// this is a common row widget
/// by this widget, each cell or a row is generated based on the row type that is provided in the column widget
class RowFieldWidget extends StatefulWidget {
  const RowFieldWidget({required this.rowFieldWidgetModel, super.key});
  /// it takes only a RowFieldWidgetModel type
  final RowFieldWidgetModel rowFieldWidgetModel;

  @override
  State<RowFieldWidget> createState() => _RowFieldWidgetState();
}

class _RowFieldWidgetState extends State<RowFieldWidget> {
  @override
  Widget build(BuildContext context) {
    /// checking the row type
    switch(widget.rowFieldWidgetModel.type){

      /// if the row is readonly plain text field
      case RowFieldWidgetType.textWidget:
        return CustomTextWidgetUI(
            showLabel: widget.rowFieldWidgetModel.value == null? "-": widget.rowFieldWidgetModel.value.toString(),
            textAlign: widget.rowFieldWidgetModel.textAlign,
            textStyle: widget.rowFieldWidgetModel.style);
    /// if the row is readonly plain currency field
      case RowFieldWidgetType.currency:
        return CustomTextWidgetUI(
            showLabel: widget.rowFieldWidgetModel.value == null? "\$ 0": "\$ ${widget.rowFieldWidgetModel.value.toString()}",
            textAlign: widget.rowFieldWidgetModel.textAlign,
            textStyle: widget.rowFieldWidgetModel.style);
    /// if the row is edit text field
      case RowFieldWidgetType.editText:
        return CustomEditTextWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel);
    /// if the row is dropdown field
      case RowFieldWidgetType.dropdown:
        return CustomDropDownWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel,);
    /// if the row is clickable text field
      case RowFieldWidgetType.clickable:
        return CustomClickableWidgetUI(rowFieldWidgetModel: widget.rowFieldWidgetModel);
    /// if the row is custom widget field
    /// this case the value must be a widget
      case RowFieldWidgetType.customWidget:
        return widget.rowFieldWidgetModel.value is Widget? widget.rowFieldWidgetModel.value: const CustomTextWidgetUI(showLabel: "Empty Data", textStyle: TextStyle(),);
      default:
        /// nothing
        return const SizedBox();
    }
  }
}
