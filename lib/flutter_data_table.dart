library flutter_data_table;

/// ================ export library ========================
export 'package:flutter_data_table/widget/column_header_widget_ui.dart';
export 'package:flutter_data_table/widget/custom_check_box_widget.dart';
export 'package:flutter_data_table/widget/row_field_widget_ui.dart';
export 'models/column_header_model.dart';
export 'models/column_widget_model.dart';
export 'models/row_field_widget.dart';
export 'models/row_widget.dart';
export 'package:flutter_data_table/models/checkbox_widget_model.dart';

/// ======================== import other library ====================
import 'package:flutter/material.dart';
import 'package:flutter_data_table/utils/responsive_size.dart';
import 'package:flutter_data_table/widget/column_header_widget_ui.dart';
import 'package:flutter_data_table/widget/custom_check_box_widget.dart';
import 'package:flutter_data_table/widget/row_field_widget_ui.dart';
import 'models/column_header_model.dart';
import 'models/column_widget_model.dart';
import 'models/row_field_widget.dart';
import 'models/row_widget.dart';

class FlutterDataTable extends StatefulWidget {
  FlutterDataTable(
      {required this.columnModel,
        required this.rowsData,
        this.colors,
        this.isCheckBoxMultiSelectAllowed = false,
        this.sort,
        this.padding,
        this.isLoadMoreDataAllowed = true,
        this.onLoadMoreData,
        this.rowHeight,
        this.columnHeight,
        this.verticalController,
        this.noDataWidget,
        this.onSave,
        this.isRefreshAllowed = false,
        this.onRefresh,
        this.onRowSelectBuilder,
        this.tableDecoration,
        this.isSortAllowed = false,
        super.key});

  final ColumnWidgetModel columnModel;
  List<RowWidgetModel> rowsData;
  final RowColor? colors;
  final BoxDecoration? tableDecoration;
  final EdgeInsetsGeometry? padding;
  final ScrollController? verticalController;
  Function(List<RowWidgetModel> editedField)? onSave;
  final bool isRefreshAllowed;
  final Future<void> Function()? onRefresh;
  final bool isLoadMoreDataAllowed;
  final Future<void> Function()? onLoadMoreData;
  final Function(ColumnHeaderModel<dynamic> element)? sort;
  final Widget? noDataWidget;
  final double? rowHeight;
  final double? columnHeight;
  final Function(List<RowWidgetModel> selectedRowList)? onRowSelectBuilder;
  final bool isCheckBoxMultiSelectAllowed;
  final bool isSortAllowed;

  @override
  State<FlutterDataTable> createState() => _FlutterDataTableState();
}

class _FlutterDataTableState extends State<FlutterDataTable> {
  String sortedColumnHeader = "";
  ScrollController innerVerticalController = ScrollController();
  bool isFixedWidthGiven = true;
  List<RowWidgetModel> selectedRowList = [];
  @override
  void initState() {
    super.initState();
    selectedRowList = [];
    setColumnOrderNumber();
    if(widget.verticalController != null){
      innerVerticalController = widget.verticalController!;
    }
    if(widget.verticalController == null){
      innerVerticalController.addListener(verticalScrollListener);
    }

  }

  setColumnOrderNumber(){
    for(int i = 0; i < widget.columnModel.columnsList.length - 1; i++){
      if(widget.columnModel.columnsList[i].orderNumber == null){
        widget.columnModel.columnsList[i].orderNumber = i;
      }
    }
  }

  isTakeTotalWidth(){
    // bool isFixedWidthGiven = false;
    if(widget.columnModel.columnsList.length <= 4){
      for(ColumnHeaderModel col in widget.columnModel.columnsList){
        if(col.fixedWidth != null){
          isFixedWidthGiven = false;
          return;
        }
      }
    }
  }
  verticalScrollListener(){
    if (widget.isLoadMoreDataAllowed && widget.onLoadMoreData != null
        && innerVerticalController.position.maxScrollExtent == innerVerticalController.position.pixels
        && innerVerticalController.position.maxScrollExtent != innerVerticalController.position.minScrollExtent
    ){
      sortedColumnHeader = "";
      widget.onLoadMoreData!();
    }
  }

  @override
  Widget build(BuildContext context) {
    isTakeTotalWidth();
    if(widget.columnModel.columnsList.isEmpty || widget.rowsData.isEmpty){
      return widget.noDataWidget?? const Center(child: Text("No data found"),);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // physics: widget.columnModel.columnsList.length <= 4? const NeverScrollableScrollPhysics() : const ScrollPhysics(),
      child: Padding(
        padding: widget.padding??const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? Responsive.width(100, context) : null,
          clipBehavior: Clip.antiAlias,
          decoration: widget.tableDecoration?? BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.pixel(2, context)),
                topRight: Radius.circular(Responsive.pixel(2, context)),
              ),
              border: Border.all(color: Colors.green)),
          child: Column(
            children: [
              SizedBox(
                width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? Responsive.width(100, context) : null,

                height: widget.columnHeight??Responsive.height(4, context),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: columnHeaderList(),
                ),
              ),
              Expanded(
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      if(widget.isRefreshAllowed){
                        if(widget.onRefresh != null){
                          selectAll(false);
                          widget.onRefresh!();
                        }
                      }
                    },
                    notificationPredicate: (val){
                      return widget.isRefreshAllowed;
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: innerVerticalController,//widget.verticalController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // shrinkWrap: true,
                        children: rowList(),
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectAll(bool value, [RowWidgetModel? row]){
    if(value){
      for(RowWidgetModel rowWidgetModel in widget.rowsData){
        if(!rowWidgetModel.isSelected){
          rowWidgetModel.isSelected = true;
          selectedRowList.add(rowWidgetModel);
        }
      }
    }else {
      for(RowWidgetModel rowWidgetModel in widget.rowsData){
        rowWidgetModel.isSelected = false;
      }
      selectedRowList = [];
    }
    if(widget.onRowSelectBuilder != null){
      widget.onRowSelectBuilder!(selectedRowList);
    }

    setState(() {

    });
  }

  List<Widget> columnHeaderList() {
    List<Widget> list = [];
    widget.columnModel.columnsList.sort((a, b) =>a.orderNumber??0.compareTo(b.orderNumber??0));
    // for (ColumnHeaderModel element in widget.columnModel.columnsList.getRange(0, widget.columnModel.columnsList.length - 1)) {
    if(widget.isCheckBoxMultiSelectAllowed){
      list.add(
          Container(
            padding: EdgeInsets.symmetric(vertical: Responsive.height(1, context)),
            decoration: BoxDecoration(
                color: widget.columnModel.backgroundColor?? Colors.green,
                border: widget.columnModel.headerBorder? Border(
                    right: BorderSide(color: widget.columnModel.headerBorderColor?? Colors.white)
                ):null),
            child: CustomCheckBoxWidgetUI(
              value: widget.rowsData.length == selectedRowList.length,
              onChange: selectAll,
              activeColor: widget.columnModel.checkBoxWidgetModel?.activeColor,
              checkColor: widget.columnModel.checkBoxWidgetModel?.checkColor,
              side: widget.columnModel.checkBoxWidgetModel?.side,
            ),
          )
      );
    }
    if(widget.isSortAllowed){
      widget.columnModel.isSortable = true;
    }
    for(int i = 0; i < widget.columnModel.columnsList.length - 1; i++){
      ColumnHeaderModel element = widget.columnModel.columnsList[i];
      if(element.orderNumber == -1){
        continue;
      }
      list.add(
          getAspectByColumnLength(
              InkWell(
                onTap: widget.columnModel.isSortable && (element.columnType == RowFieldWidgetType.textWidget || element.columnType == RowFieldWidgetType.currency)
                    ? () {
                  if(widget.sort == null){
                    sortedColumnHeader = onSort(element.slug, i, sortedColumnHeader == element.slug) ?? "";
                  }
                  else {
                    if(widget.columnModel.onSort != null){
                      widget.columnModel.onSort!();
                    }
                    else {
                      widget.sort!(element);
                    }
                    sortedColumnHeader = element.slug;
                  }
                  setState(() {

                  });
                }
                    : null,
                child: ColumnHeaderWidgetUI(
                  columnHeaderData: element,
                  isSortable: widget.columnModel.isSortable && (element.columnType == RowFieldWidgetType.textWidget || element.columnType == RowFieldWidgetType.currency),
                  sortedColumn: sortedColumnHeader,
                  backgroundColor: widget.columnModel.backgroundColor,
                  style: widget.columnModel.style,
                ),
              ),
              fixedWidth: element.fixedWidth
          )
      );
    }
    list.add(
        getAspectByColumnLength(
            InkWell(
              onTap: widget.columnModel.isSortable && widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.textWidget
                  ? () {
                if(widget.sort == null){
                  sortedColumnHeader = onSort(widget.columnModel.columnsList.last.slug, widget.columnModel.columnsList.length - 1, sortedColumnHeader == widget.columnModel.columnsList.last.slug) ?? "";
                }
                else{
                  sortedColumnHeader = widget.columnModel.columnsList.last.slug;
                  widget.sort!(widget.columnModel.columnsList.last);
                }
                setState(() {

                });
              }
                  : null,
              child: ColumnHeaderWidgetUI(
                columnHeaderData: widget.columnModel.columnsList.last,
                isSortable: widget.columnModel.isSortable && (widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.textWidget || widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.currency),
                sortedColumn: sortedColumnHeader,
                backgroundColor: widget.columnModel.backgroundColor,
                style: widget.columnModel.style,
                headerBorder: false,
              ),
            ),
            fixedWidth: widget.columnModel.columnsList.last.fixedWidth
        )
    );
    return list;
  }

  Widget getAspectByColumnLength(Widget anyWidget, {double? fixedWidth}) {
    if (widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven) {
      return Expanded(child: anyWidget);
    }
    return SizedBox(
        width: Responsive.width(fixedWidth??30, context),
        child: anyWidget
    );
  }

  selectARow(bool value, [RowWidgetModel? row]){
    if(row != null){

      row.isSelected = !row.isSelected;
      if(row.isSelected){
        selectedRowList.add(row);
      }
      else{
        if(selectedRowList.contains(row)){
          selectedRowList.remove(row);
        }
      }
      setState(() {

      });
    }
    if(widget.onRowSelectBuilder != null){
      widget.onRowSelectBuilder!(selectedRowList);
    }
  }


  List<Widget> rowList() {
    List<Widget> rows = [];
    for (RowWidgetModel rowWidgetModel in widget.rowsData) {
      List<Widget> rowChildren = [];
      rowWidgetModel.rowFieldList.sort((a, b) => a.order!.compareTo(b.order!));
      if(widget.isCheckBoxMultiSelectAllowed){
        rowChildren.add(
            SizedBox(
              height: widget.rowHeight??Responsive.height(3, context),
              child: CustomCheckBoxWidgetUI(
                value: rowWidgetModel.isSelected,
                row: rowWidgetModel,
                onChange: selectARow,
                activeColor: rowWidgetModel.checkBoxWidgetModel?.activeColor,
                checkColor: rowWidgetModel.checkBoxWidgetModel?.checkColor,
                side: rowWidgetModel.checkBoxWidgetModel?.side,
              ),
            )
        );
      }
      for (RowFieldWidgetModel rowFieldWidgetModel in rowWidgetModel.rowFieldList) {
        if(rowFieldWidgetModel.order == -1){
          continue;
        }

        rowChildren.add(
            getAspectByColumnLength(
                SizedBox(
                  height: widget.rowHeight??Responsive.height(2.5, context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Responsive.width(4, context)),
                    child: RowFieldWidget(rowFieldWidgetModel: rowFieldWidgetModel),
                  ),
                ),
                fixedWidth: rowFieldWidgetModel.fixedWidth
            )
        );
      }
      rows.add(InkWell(
        onTap: rowWidgetModel.rowClickable
            ? selectedRowList.isEmpty? rowWidgetModel.onRowClick : (){selectARow(true, rowWidgetModel);}
            : null,
        onLongPress: widget.isCheckBoxMultiSelectAllowed? (){
          selectARow(true, rowWidgetModel);
        }:null,
        child: Container(
          width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? Responsive.width(100, context) : null,
          color: !rowWidgetModel.isSelected? widget.colors != null? widget.rowsData.indexOf(rowWidgetModel) % 2 == 0? widget.colors!.color1 : widget.colors!.color2 : Colors.white : null,
          padding: EdgeInsets.symmetric(vertical: Responsive.height(0.5, context)),
          decoration: rowWidgetModel.isSelected?BoxDecoration(
              color: !rowWidgetModel.isSelected? widget.colors != null? widget.rowsData.indexOf(rowWidgetModel) % 2 == 0? widget.colors!.color1 : widget.colors!.color2 : Colors.white : Colors.lightGreenAccent,
              border: const Border(bottom: BorderSide(color: Colors.green))
          ):null,
          child: Row(
            children: rowChildren,
          ),
        ),
      ));
    }
    return rows;
  }

  String? onSort(String slug, int index, bool hasSorted) {
    if(!hasSorted){
      List<RowWidgetModel> sortRowDate = [];
      List<RowWidgetModel> sortRowEmpty = [];
      List<RowWidgetModel> sortRowInt = [];
      List<RowWidgetModel> sortRowString = [];

      for(RowWidgetModel row in widget.rowsData){
        for(RowFieldWidgetModel field in row.rowFieldList){
          if(field.columnName == slug){
            if(field.value is num){
              sortRowInt.add(row);
            }
            else if(field.value is DateTime){
              sortRowDate.add(row);
            }
            else if(field.value is String){
              if(num.tryParse(field.value) != null){
                field.value = num.parse(field.value);
                sortRowInt.add(row);
              }
              else if(DateTime.tryParse(field.value) != null){
                field.value = DateTime.parse(field.value);
                sortRowDate.add(row);
              }
              else{
                sortRowString.add(row);
              }
            }
            else{
              sortRowEmpty.add(row);
            }
            break;
          }
        }
      }

      sortRowInt.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));
      sortRowString.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));
      sortRowDate.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));
      widget.rowsData = [...sortRowEmpty, ...sortRowInt, ...sortRowString, ...sortRowDate];
    }
    else{
      widget.rowsData = widget.rowsData.reversed.toList();
    }
    return slug;
  }

  List<RowWidgetModel> getEditedRows(){
    List<RowWidgetModel> list = [];
    for(RowWidgetModel row in widget.rowsData){
      for(RowFieldWidgetModel field in row.rowFieldList){
        if(field.type == RowFieldWidgetType.editText){
          print(field.value);
          if(field.value != null){
            if(field.value.toString().isNotEmpty){
              list.add(row);
              break;
            }
          }

        }
        if(field.type == RowFieldWidgetType.dropdown){
          if(field.value != null){
            list.add(row);
            break;
          }

        }
      }
    }
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.verticalController == null){
      if(innerVerticalController.hasListeners){
        innerVerticalController.removeListener(() { });
      }
      innerVerticalController.dispose();
    }

    if(widget.onSave != null){
      widget.onSave!(getEditedRows());
    }
  }
}
