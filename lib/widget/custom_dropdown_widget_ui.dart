import 'package:flutter/material.dart';

import '../models/custom_table_dropdown_model.dart';
import '../models/row_field_widget.dart';

/// this is the dropdown cell widget
class CustomDropDownWidgetUI<T> extends StatefulWidget {
  CustomDropDownWidgetUI({required this.rowFieldWidgetModel, super.key});
  /// it takes only one parameter rowFieldWidgetModel
  /// which is RowFieldWidgetModel
  RowFieldWidgetModel<T> rowFieldWidgetModel;
  @override
  State<CustomDropDownWidgetUI> createState() => _CustomDropDownWidgetUIState();
}

class _CustomDropDownWidgetUIState extends State<CustomDropDownWidgetUI> {

  @override
  void initState() {
    super.initState();
    /// getting the initial value
    initValue();
  }

  /// getting the initial value by the function
  initValue(){
    if(widget.rowFieldWidgetModel.value != null){
      if(widget.rowFieldWidgetModel.value is CustomTableDropDownModel){
        for(CustomTableDropDownModel element in widget.rowFieldWidgetModel.dropDownOptionsList){
          if(element.label == widget.rowFieldWidgetModel.value.label){
            /// setting the initial value
            widget.rowFieldWidgetModel.value = element;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CustomTableDropDownModel>(
      decoration: const InputDecoration(
        contentPadding:  EdgeInsets.zero,
        isDense: true,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        ),

      isExpanded: true,
      hint: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'please select',
              style: widget.rowFieldWidgetModel.style?? const TextStyle(
                color: Colors.black
              )
          ),
        ]),
      ),
      /// setting the value
      value: widget.rowFieldWidgetModel.value,
      onChanged: (newValue) {
        /// on change the dropdown
        if(newValue != null){
          if(widget.rowFieldWidgetModel.onDropDownValueChange != null){
            /// onDropDownValueChange calls when any changes on dropdown for this row cell
            widget.rowFieldWidgetModel.onDropDownValueChange!(newValue, widget.rowFieldWidgetModel);
          }
          /// setting the new value to the row field value
          widget.rowFieldWidgetModel.value = newValue;
          setState(() {

          });
        }


      },
      /// initializing the dropdown list from the fow widget model options list
      items: widget.rowFieldWidgetModel.dropDownOptionsList.map((element) {
        return DropdownMenuItem<CustomTableDropDownModel>(
          value: element,
          child: Text(
            /// showing only the label
            element.label,
            style: widget.rowFieldWidgetModel.style??const TextStyle(
                color: Colors.black
            ),
          ),
        );
      }).toList(),
    );
  }

}

