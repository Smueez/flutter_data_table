import 'package:flutter/material.dart';
import '../models/row_widget.dart';


/// checkbox ui if multi select is enabled
/// this only will shown if multi select enabled from the table
class CustomCheckBoxWidgetUI extends StatefulWidget {
  CustomCheckBoxWidgetUI({this.value = false, this.row, this.activeColor, this.checkColor, this.side, this.onChange,  super.key});
  /// true / false
  bool value;

  /// row widget model
  RowWidgetModel? row;

  /// this is the decoration of checkbox
  BorderSide? side;

  /// this is the activate color
  Color? activeColor;

  /// this is the check mark color
  Color? checkColor;
  Function(bool value, [RowWidgetModel? row])? onChange;
  @override
  State<CustomCheckBoxWidgetUI> createState() => _CustomCheckBoxWidgetUIState();
}

class _CustomCheckBoxWidgetUIState extends State<CustomCheckBoxWidgetUI> {

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Center(
        /// check box ui
        child: Checkbox(
            value: widget.value,
            activeColor: widget.activeColor,
            checkColor: widget.checkColor,
            /// adding decoration of the checkbox
            side:MaterialStateBorderSide.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return widget.side;
              }
              else{
                return widget.side;
              }
            }),
            /// on change function
            onChanged: (value){
              /// altering the value of checkbox
              widget.value = !widget.value;
              if(widget.onChange != null){
                /// calling onChange function
                widget.onChange!(value??false, widget.row);
              }
            }
        ),
      ),
    );
  }
}
