import 'package:flutter/material.dart';
import '../models/row_widget.dart';

class CustomCheckBoxWidgetUI extends StatefulWidget {
  CustomCheckBoxWidgetUI({this.value = false, this.row, this.activeColor, this.checkColor, this.side, this.onChange,  super.key});
  bool value;
  RowWidgetModel? row;
  BorderSide? side;
  Color? activeColor;
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
        child: Checkbox(
            value: widget.value,
            activeColor: widget.activeColor,
            checkColor: widget.checkColor,
            side:MaterialStateBorderSide.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return widget.side;
              }
              else{
                return widget.side;
              }
            }),
            // fillColor: MaterialStateProperty.all(Colors.white),
            onChanged: (value){
              widget.value = !widget.value;
              if(widget.onChange != null){
                widget.onChange!(value??false, widget.row);
              }
            }
        ),
      ),
    );
  }
}
