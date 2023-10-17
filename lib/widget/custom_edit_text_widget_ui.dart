import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/row_field_widget.dart';

/// this is the edit text widget for row cell
class CustomEditTextWidgetUI extends StatefulWidget {
  CustomEditTextWidgetUI({required this.rowFieldWidgetModel, super.key});
  RowFieldWidgetModel rowFieldWidgetModel;
  @override
  State<CustomEditTextWidgetUI> createState() => _CustomEditTextWidgetUIState();
}

class _CustomEditTextWidgetUIState extends State<CustomEditTextWidgetUI> {
  @override
  Widget build(BuildContext context) {
    /// text form field used to initialize the edit text field
    return TextFormField(
      initialValue: widget.rowFieldWidgetModel.value == null? "" : widget.rowFieldWidgetModel.value.toString(),
      /// providing the keyboard type
      keyboardType: widget.rowFieldWidgetModel.inputType == InputType.number? TextInputType.number: TextInputType.text,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      /// providing the input type
      inputFormatters: widget.rowFieldWidgetModel.inputType == InputType.number? [FilteringTextInputFormatter.digitsOnly]: null,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        isDense: true,
        isCollapsed: true,
      ),
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: (value) {
        /// on change function calls on when changes has been occurred
        widget.rowFieldWidgetModel.value = value;
        if(widget.rowFieldWidgetModel.onEditTextValueChange != null){
          /// onEditTextValueChange calls when the particular field changes
          widget.rowFieldWidgetModel.onEditTextValueChange!(value, widget.rowFieldWidgetModel);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
