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
  String editedText = "";
  TextEditingController controller = TextEditingController();
  List<TextInputFormatter>? inputFormatter;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    setInputFormatter();
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

  setInputFormatter(){
    if(widget.rowFieldWidgetModel.inputType == InputType.number){
      inputFormatter = [
        /// allow only number and dot:
        FilteringTextInputFormatter.allow(RegExp("[0-9\\.]")),

        /// avoiding multiple dot:
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
      ];
    }
    else if(widget.rowFieldWidgetModel.inputType == InputType.numberOnly){
      inputFormatter = [
        /// allow only number
        FilteringTextInputFormatter.digitsOnly,
      ];
    }
    else if(widget.rowFieldWidgetModel.inputType == InputType.numberWith2DecimalPoint){
      inputFormatter = [
        /// allow only number and dot:
        FilteringTextInputFormatter.allow(RegExp("[0-9\\.]")),

        /// avoiding multiple dot and for only 2 digit:
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ];
    }
    else {
      inputFormatter = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// assigning initial value when the widget is built
    controller.text = widget.rowFieldWidgetModel.value == null? "" : widget.rowFieldWidgetModel.value.toString();
    /// text form field used to initialize the edit text field
    return TextFormField(
      // initialValue: widget.rowFieldWidgetModel.value == null? "" : widget.rowFieldWidgetModel.value.toString(),
      focusNode: focusNode,
      /// providing the keyboard type
      keyboardType: widget.rowFieldWidgetModel.inputType != InputType.string? TextInputType.number: TextInputType.text,
      textAlign: TextAlign.center,
      /// providing the input type
      inputFormatters: inputFormatter,
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
    controller.dispose();
  }
}
