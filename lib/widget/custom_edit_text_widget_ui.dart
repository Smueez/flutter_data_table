import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/row_field_widget.dart';

class CustomEditTextWidgetUI extends StatefulWidget {
  CustomEditTextWidgetUI({required this.rowFieldWidgetModel, super.key});
  RowFieldWidgetModel rowFieldWidgetModel;
  @override
  State<CustomEditTextWidgetUI> createState() => _CustomEditTextWidgetUIState();
}

class _CustomEditTextWidgetUIState extends State<CustomEditTextWidgetUI> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.rowFieldWidgetModel.value == null? "" : widget.rowFieldWidgetModel.value.toString(),
      keyboardType: widget.rowFieldWidgetModel.inputType == InputType.number? TextInputType.number: TextInputType.text,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
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
        widget.rowFieldWidgetModel.value = value;
        if(widget.rowFieldWidgetModel.onEditTextValueChange != null){
          widget.rowFieldWidgetModel.onEditTextValueChange!(value, widget.rowFieldWidgetModel);
        }
        print(widget.rowFieldWidgetModel.value);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
