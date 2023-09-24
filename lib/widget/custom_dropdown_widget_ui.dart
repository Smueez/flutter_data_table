import 'package:flutter/material.dart';

import '../models/custom_table_dropdown_model.dart';
import '../models/row_field_widget.dart';


class CustomDropDownWidgetUI<T> extends StatefulWidget {
  CustomDropDownWidgetUI({required this.rowFieldWidgetModel, super.key});
  RowFieldWidgetModel<T> rowFieldWidgetModel;
  @override
  State<CustomDropDownWidgetUI> createState() => _CustomDropDownWidgetUIState();
}

class _CustomDropDownWidgetUIState extends State<CustomDropDownWidgetUI> {

  @override
  void initState() {
    super.initState();
    initValue();
  }

  initValue(){
    if(widget.rowFieldWidgetModel.value != null){
      if(widget.rowFieldWidgetModel.value is CustomTableDropDownModel){
        for(CustomTableDropDownModel element in widget.rowFieldWidgetModel.options){
          if(element.label == widget.rowFieldWidgetModel.value.label){
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
          // TextSpan(
          //     text: widget.isMandatory ? '*' : '',
          //     style: const TextStyle(
          //         fontStyle: FontStyle.normal, color: Colors.red)),
        ]),
      ),

      value: widget.rowFieldWidgetModel.value,
      onChanged: (newValue) {
        if(newValue != null){
          if(widget.rowFieldWidgetModel.onChange != null){
            widget.rowFieldWidgetModel.onChange!(newValue, widget.rowFieldWidgetModel);
          }
          widget.rowFieldWidgetModel.value = newValue;
          setState(() {

          });
        }


      },
      items: widget.rowFieldWidgetModel.options.map((element) {
        return DropdownMenuItem<CustomTableDropDownModel>(
          value: element,
          child: Text(
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

