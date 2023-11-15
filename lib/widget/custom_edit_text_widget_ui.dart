import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_data_table/utils/responsive_size.dart';

import '../models/row_field_widget.dart';

/// this is the edit text widget for row cell
class CustomEditTextWidgetUI extends StatefulWidget {
  CustomEditTextWidgetUI({required this.rowFieldWidgetModel, super.key});
  RowFieldWidgetModel rowFieldWidgetModel;
  @override
  State<CustomEditTextWidgetUI> createState() => _CustomEditTextWidgetUIState();
}

class _CustomEditTextWidgetUIState extends State<CustomEditTextWidgetUI> {
  String editedText = "";

  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    /// onEditTextValueChange calls after the particular field changes
    focusNode.addListener(() {
      if(!focusNode.hasFocus){
        if(widget.rowFieldWidgetModel.onEditTextValueChange != null){
          /// onEditTextValueChange calls after the particular field changes
          widget.rowFieldWidgetModel.onEditTextValueChange!(editedText, widget.rowFieldWidgetModel);
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    /// text form field used to initialize the edit text field
    return TextFormField(
      initialValue: widget.rowFieldWidgetModel.value == null? "" : widget.rowFieldWidgetModel.value.toString(),
      focusNode: focusNode,
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
        /// focus changes when on edit is completed
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onTapOutside: (value){
        /// focus changes when on tapped outside of the widget
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onFieldSubmitted: (value){
        /// focus changes when on field is submitted
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value){
        /// focus changes when on save is called
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: (value) {
        /// on change method calls when changing the value of edit text field
        widget.rowFieldWidgetModel.value = value;
        editedText = value;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(() { });
  }
}
