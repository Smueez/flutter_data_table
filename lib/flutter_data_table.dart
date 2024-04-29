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
import 'package:flutter_data_table/widget/custom_text_widget_ui.dart';
import 'package:flutter_data_table/widget/row_field_widget_ui.dart';
import 'models/column_header_model.dart';
import 'models/column_widget_model.dart';
import 'models/row_field_widget.dart';
import 'models/row_widget.dart';

/// Flutter data table widget
/// this is the main widget that you will call in your UI
/// this is the constructor of the widget called FlutterDataTable
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
        this.headerHeight,
        this.verticalController,
        this.noDataWidget,
        this.onSave,
        this.isRefreshAllowed = false,
        this.onRefresh,
        this.onRowSelectBuilder,
        this.tableDecoration,
        this.isSortAllowed = false,
        this.isSerialNumberColumnAllowed = false,
        this.slNoColumnName,
        this.serialNumColumnWidth,
        this.selectedRowColor,
        super.key});

  /// this is the column model
  /// this is the required field of ColumnWidgetModel type
  final ColumnWidgetModel columnModel;

  /// This is the list of RowWidgetModel
  /// This is also a required field
  /// This is the list of the rows of the table.
  List<RowWidgetModel> rowsData;

  /// This is a RowColor type
  /// This field is used to separate 2 adjacent row by 2 different color
  final RowColor? colors;

  /// With this you can decorate the Container of the table.
  /// this accepts only BoxDecoration type
  final BoxDecoration? tableDecoration;

  /// this is for padding the table
  final EdgeInsetsGeometry? padding;

  /// This is the scroll controller.
  /// This is not recommended as the table is fully responsible of it's own scroll controller.
  /// If you provide this controller then the table won't have infinity scroll mode.
  final ScrollController? verticalController;

  /// This is function.
  /// This function executes when the widget is disposed
  /// This function gives us the list of rows where changes have been occurred.
  /// This function usually give back the rows of of the changed value of Dropdown and Edit text field
  Function(List<RowWidgetModel> editedField)? onSave;

  /// This boolean indicates if pull to refresh functionality is enabled.
  /// But after making this field to True, you have to provide the OnRefresh() method,
  /// by which the rows will be refreshed
  final bool isRefreshAllowed;

  /// This is a function.
  /// This is called when isRefreshAllowed is true and user initiate a pull to refresh
  /// This function gives the table a pull to refresh functionality
  final Future<void> Function()? onRefresh;

  /// This boolean indicates the load more or infinity functionality of the table.
  ///  By making this True, data table will get an infinite scroll.
  final bool isLoadMoreDataAllowed;

  /// This is a function.
  /// This function will be called when the data table reach the end of the scroll and if isLoadMoreDataAllowed is True.
  /// This functionality is used to get more data when table data reached it's end of scroll
  final Future<void> Function()? onLoadMoreData;

  /// This is a user defined sort function.
  /// This gives a global sort mechanism for the data table.
  /// This is not mandatory or not re-commanded as the table has it's own dynamic sort mechanism.
  final Function(ColumnHeaderModel<dynamic> element)? sort;

  /// This is a widget.
  /// This widget is called when there is no data in the table.
  final Widget? noDataWidget;

  /// This is a double value
  /// Which gives all the row a fixed height.
  final double? rowHeight;

  /// This is a double value
  /// Which gives the headers a fixed height.
  final double? headerHeight;

  /// This is a builder function
  /// If multi-select mode is enabled, then after selecting each row this function is called. (isCheckBoxMultiSelectAllowed == true)
  /// You can get selected rows by this builder function.
  final Function(List<RowWidgetModel> selectedRowList)? onRowSelectBuilder;

  /// This is a boolean value.
  /// This value indicates if multiselect rows allowed with checkbox.
  /// By enabling this by making it True, the table will be get the multi select functionality
  final bool isCheckBoxMultiSelectAllowed;

  /// This is a boolean field.
  /// This indicates if you want to have sorting mechanism in your table.
  /// Sort is done by the table it self.
  /// Sort function is very dynamic here.
  /// That means the sort function will work on any type of dta type in text field or clickable text field
  final bool isSortAllowed;

  /// This is a boolean field.
  /// Which indicates if you want to have serial number in the table.
  final bool isSerialNumberColumnAllowed;

  /// This is a String field.
  /// This is basically the column name of serial number column. By default it is "Sl No".
  final String? slNoColumnName;

  /// This accepts the double type
  /// This will allow you to provide the width of Serial number column width.
  final double? serialNumColumnWidth;

  /// This accepts the Color type
  ///  If the multi-select enabled, this color will be used as a highlighter color for the selected row.
  final Color? selectedRowColor;

  @override
  State<FlutterDataTable> createState() => _FlutterDataTableState();
}

class _FlutterDataTableState extends State<FlutterDataTable> {

  /// This is the global header string,
  /// This is the global string, on which the code understands which header was sorted last time
  String sortedColumnHeader = "";

  /// this is the scroll controller
  ScrollController innerVerticalController = ScrollController();

  /// This is for the fixed width enabled
  bool isFixedWidthGiven = true;

  /// this is the list of selected rows
  /// only if multi selection is enabled
  List<RowWidgetModel> selectedRowList = [];

  /// ths flag is used for select multiple row
  bool selectedAllRowsFlag = false;

  @override
  void initState() {
    super.initState();
    /// clearing the selectedRowList
    selectedRowList = [];

    /// setting column order number if the ordernumber is not given
    setColumnOrderNumber();

    /// initializing the vertical scroll controller
    if(widget.verticalController != null){
      innerVerticalController = widget.verticalController!;
    }
    /// adding listener
    if(widget.verticalController == null){
      innerVerticalController.addListener(verticalScrollListener);
    }

  }

  /// setting column order number if the ordernumber is not given
  setColumnOrderNumber(){
    for(int i = 0; i < widget.columnModel.columnsList.length ; i++){
      if(widget.columnModel.columnsList[i].orderNumber == -1){
        widget.columnModel.columnsList[i].orderNumber = i;
      }
    }
  }

  /// This is for the fixed width enabled
  isTakeTotalWidth(){
    if(widget.columnModel.columnsList.length <= 4){
      for(ColumnHeaderModel col in widget.columnModel.columnsList){
        if(col.fixedWidth != null){
          isFixedWidthGiven = false;
          return;
        }
      }
    }
  }

  /// vertical scroll listener
  /// this allows infinite scroll functionalty
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
    /// Checking if there is any data in the table
    if(widget.columnModel.columnsList.isEmpty){
      return widget.noDataWidget?? const Center(child: Text("No data found"),);
    }

    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            /// padding for the table
            padding: widget.padding??const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              /// takes full width if the column size is less or equal to 4
              width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? FlutterDataTableResponsive.width(100, context) : null,
              clipBehavior: Clip.antiAlias,

              /// table decoration
              decoration: widget.tableDecoration?? BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(FlutterDataTableResponsive.pixel(2, context)),
                    topRight: Radius.circular(FlutterDataTableResponsive.pixel(2, context)),
                  ),
                  border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  SizedBox(
                    /// takes full width if the column size is less or equal to 4
                    width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? FlutterDataTableResponsive.width(100, context) : null,

                    /// column header fixed height
                    height: widget.headerHeight??FlutterDataTableResponsive.height(4, context),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      /// adding column list
                      children: columnHeaderList(),
                    ),
                  ),
                  Expanded(
                    /// pull to refresh with RefreshIndicator
                      child: RefreshIndicator(
                        onRefresh: ()async{
                          /// checking if pull to refresh is allowed
                          if(widget.isRefreshAllowed){
                            if(widget.onRefresh != null){
                              /// cancel all selected rows
                              selectAll(false);
                              /// initiate the pull to refresh
                              widget.onRefresh!();
                            }
                          }
                        },
                        notificationPredicate: (val){
                          /// checking if pull to refresh is allowed
                          return widget.isRefreshAllowed;
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          /// vertical scroll controller
                          controller: innerVerticalController,//widget.verticalController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            /// adding row list
                            children: rowList(),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      if(widget.rowsData.isEmpty)
      widget.noDataWidget?? const Center(child: Text("No data found"),)
      ],
    );
  }

  /// select all rows function
  /// This function will use only when multi select is allowed
  selectAll(bool value, [RowWidgetModel? row]){
    selectedAllRowsFlag = value;
    if(value){
      for(RowWidgetModel rowWidgetModel in widget.rowsData){
        if(!rowWidgetModel.isSelected && rowWidgetModel.canBeSelected){
          /// adding row to the list if the rows are enable for multi select
          rowWidgetModel.isSelected = true;
          selectedRowList.add(rowWidgetModel);
        }
        else {
          /// removing the rows from the selected list if the rows are enable for multi select
          if(! selectedAllRowsFlag){
            rowWidgetModel.isSelected = false;
            selectedRowList.remove(rowWidgetModel);
          }

        }
      }
    }else {
      /// removing all row from the list
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

  /// check if sorting is allowed
  /// sort is allowed if isSortAllowed is true
  /// there is no Edit Text field in table
  /// for dropdown field or custom field there will be no sort for those particular columns.
  checkIfSortableAllowed(){
    if(widget.isSortAllowed){
      for(int i = 0; i < widget.columnModel.columnsList.length; i++){
        ColumnHeaderModel element = widget.columnModel.columnsList[i];
        if(element.orderNumber == -1){
          continue;
        }
        if(element.columnType == RowFieldWidgetType.editText){
          return false;
        }
      }
      return true;
    }
    return false;
  }

  /// generating column list function
  List<Widget> columnHeaderList() {
    List<Widget> list = [];
    /// sort the column list according to it's order Number
    widget.columnModel.columnsList.sort((a, b) =>a.orderNumber.compareTo(b.orderNumber));

    /// if multi select enabled then checkbox is added in the column
    if(widget.isCheckBoxMultiSelectAllowed){
      list.add(
          Container(
            padding: EdgeInsets.symmetric(vertical: FlutterDataTableResponsive.height(1, context)),
            decoration: BoxDecoration(
                color: widget.columnModel.backgroundColor?? Colors.green,
                border: widget.columnModel.headerBorder? Border(
                    right: BorderSide(color: widget.columnModel.headerBorderColor?? Colors.white)
                ):null),
            child: CustomCheckBoxWidgetUI(
              value: selectedAllRowsFlag || widget.rowsData.length == selectedRowList.length,
              onChange: selectAll,
              activeColor: widget.columnModel.checkBoxWidgetStyle?.activeColor,
              checkColor: widget.columnModel.checkBoxWidgetStyle?.checkColor,
              side: widget.columnModel.checkBoxWidgetStyle?.side,
            ),
          )
      );
    }

    /// Serial number column is added when serial number is allowed
    /// It's totally auto generated
    if(widget.isSerialNumberColumnAllowed){
      list.add(
          Container(
              width: FlutterDataTableResponsive.width(widget.serialNumColumnWidth??15, context),
              height: widget.headerHeight??FlutterDataTableResponsive.height(4, context),
              padding: EdgeInsets.symmetric(vertical: FlutterDataTableResponsive.height(1, context)),
              decoration: BoxDecoration(
                  color: widget.columnModel.backgroundColor?? Colors.green,
                  border: widget.columnModel.headerBorder? Border(
                      right: BorderSide(color: widget.columnModel.headerBorderColor?? Colors.white)
                  ):null),
              child: Center(
                child: Text(
                  widget.slNoColumnName??"SL No",
                  style: widget.columnModel.style??const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
          )
      );
    }

    /// checking if sort enabled based on the logic
    widget.columnModel.isSortable = checkIfSortableAllowed();

    /// Generating column header UI by the column model list.
    for(int i = 0; i < widget.columnModel.columnsList.length - 1; i++){
      ColumnHeaderModel element = widget.columnModel.columnsList[i];
      if(element.orderNumber == -1){
        continue;
      }

      list.add(
          getAspectByColumnLength(
              InkWell(
                /// sort mechanism added
                onTap: widget.columnModel.isSortable && (element.columnType == RowFieldWidgetType.textWidget || element.columnType == RowFieldWidgetType.clickable || element.columnType == RowFieldWidgetType.currency)
                    ? () {
                  if(widget.sort == null){
                    sortedColumnHeader = onSort(element.slug, i, sortedColumnHeader == element.slug) ?? "";
                  }
                  else {
                    widget.sort!(element);
                    sortedColumnHeader = element.slug;
                  }
                  setState(() {

                  });
                }
                    : null,
                /// single column header ui
                child: ColumnHeaderWidgetUI(
                  columnHeaderData: element,
                  isSortable: widget.columnModel.isSortable && (element.columnType == RowFieldWidgetType.textWidget|| element.columnType == RowFieldWidgetType.clickable || element.columnType == RowFieldWidgetType.currency),
                  sortedColumn: sortedColumnHeader,
                  backgroundColor: widget.columnModel.backgroundColor,
                  style: widget.columnModel.style,
                ),
              ),
              fixedWidth: element.fixedWidth
          )
      );
    }
    /// Generating last column header ui
    list.add(
        getAspectByColumnLength(
            InkWell(
              onTap: widget.columnModel.isSortable && (
                  widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.textWidget
                      || widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.clickable
                      || widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.currency)
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
              /// single last column header ui
              child: ColumnHeaderWidgetUI(
                columnHeaderData: widget.columnModel.columnsList.last,
                isSortable: widget.columnModel.isSortable && (
                    widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.textWidget
                        || widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.clickable
                        || widget.columnModel.columnsList.last.columnType == RowFieldWidgetType.currency),
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

  /// Adding aspect ration of the column width or length based on other logic
  Widget getAspectByColumnLength(Widget anyWidget, {double? fixedWidth}) {
    if (widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven) {
      return Expanded(child: anyWidget);
    }
    return SizedBox(
        width: FlutterDataTableResponsive.width(fixedWidth??30, context),
        child: anyWidget
    );
  }

  /// Select a single row in multi select more
  /// Multi select mode has to be enabled for this
  selectARow(bool value, [RowWidgetModel? row]){
    if(row != null){
      if(row.canBeSelected){
        if(widget.rowsData.length == selectedRowList.length && widget.rowsData.isNotEmpty){
          selectedAllRowsFlag = true;
        }
        row.isSelected = !row.isSelected;
        if(row.isSelected){
          selectedRowList.add(row);
        }
        else{
          if(selectedRowList.contains(row)){
            selectedAllRowsFlag = false;
            selectedRowList.remove(row);
          }
        }
        setState(() {

        });
      }
    }
    if(widget.onRowSelectBuilder != null){
      /// calling onRowSelectBuilder
      widget.onRowSelectBuilder!(selectedRowList);
    }
  }

  /// Generating row list UI from row list that was provided
  List<Widget> rowList() {
    List<Widget> rows = [];
    int rowNumber = 1;
    for (RowWidgetModel rowWidgetModel in widget.rowsData) {
      List<Widget> rowChildren = [];
      /// sorting each of the row field based on it's corresponding column order number.
      rowWidgetModel.rowFieldList.sort((a, b) => a.columnHeaderModel.orderNumber.compareTo(b.columnHeaderModel.orderNumber));

      /// if multi-select is enabled then checkbox added for each row
      if(widget.isCheckBoxMultiSelectAllowed){
        rowChildren.add(
            SizedBox(
              height: widget.rowHeight??FlutterDataTableResponsive.height(3, context),
              child: CustomCheckBoxWidgetUI(
                value: rowWidgetModel.isSelected,
                row: rowWidgetModel,
                onChange: selectARow,
                activeColor: rowWidgetModel.checkBoxWidgetStyle?.activeColor,
                checkColor: rowWidgetModel.checkBoxWidgetStyle?.checkColor,
                side: rowWidgetModel.checkBoxWidgetStyle?.side,
              ),
            )
        );
      }

      /// if serial number added then serial number is added for each row
      if(widget.isSerialNumberColumnAllowed){
        rowChildren.add(
            SizedBox(
              height: widget.rowHeight??FlutterDataTableResponsive.height(3, context),
              width: FlutterDataTableResponsive.width(15, context),
              child: CustomTextWidgetUI(
                showLabel: '${rowNumber++}',
                textStyle: null,
              ),
            )
        );
      }
      for (RowFieldWidgetModel rowFieldWidgetModel in rowWidgetModel.rowFieldList) {

        /// ignoring each unwanted column
        if(rowFieldWidgetModel.columnHeaderModel.orderNumber == -1){
          continue;
        }

        /// adding cell or field for each row
        rowChildren.add(
            getAspectByColumnLength(
                SizedBox(
                  height: widget.rowHeight??FlutterDataTableResponsive.height(2.5, context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: FlutterDataTableResponsive.width(4, context)),
                    child: RowFieldWidget(rowFieldWidgetModel: rowFieldWidgetModel),
                  ),
                ),
                fixedWidth: rowFieldWidgetModel.fixedWidth
            )
        );
      }
      rows.add(InkWell(
        /// added on click functionality according to logic
        onTap: rowWidgetModel.rowClickable
            ? selectedRowList.isEmpty? rowWidgetModel.onRowClick : (){selectARow(true, rowWidgetModel);}
            :widget.isCheckBoxMultiSelectAllowed?(){selectARow(true, rowWidgetModel);} : null,
        /// added on click functionality according to logic
        /// if multi select enabled then this long press is enabled to add item in the selected list for the 1st time
        onLongPress: widget.isCheckBoxMultiSelectAllowed? (){
          selectARow(true, rowWidgetModel);
        }:null,
        /// UI for each row
        child: Container(
          width: widget.columnModel.columnsList.length <= 4 && isFixedWidthGiven? FlutterDataTableResponsive.width(100, context) : null,
          color: !rowWidgetModel.isSelected? widget.colors != null? widget.rowsData.indexOf(rowWidgetModel) % 2 == 0? widget.colors!.color1 : widget.colors!.color2 : Colors.white : null,
          padding: EdgeInsets.symmetric(vertical: FlutterDataTableResponsive.height(0.5, context)),
          decoration: rowWidgetModel.isSelected?BoxDecoration(
              color: !rowWidgetModel.isSelected? widget.colors != null? widget.rowsData.indexOf(rowWidgetModel) % 2 == 0? widget.colors!.color1 : widget.colors!.color2 : Colors.white : widget.selectedRowColor?? Colors.lightGreenAccent,
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


  /// this the dynamic sort function
  String? onSort(String slug, int index, bool hasSorted) {
    if(!hasSorted){
      List<RowWidgetModel> sortRowDate = [];
      List<RowWidgetModel> sortRowEmpty = [];
      List<RowWidgetModel> sortRowInt = [];
      List<RowWidgetModel> sortRowString = [];
      /// traversing each row
      for(RowWidgetModel row in widget.rowsData){
        /// traversing each cell for each row
        for(RowFieldWidgetModel field in row.rowFieldList){

          /// checking each row value's data type
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
      /// sorting each row according to it's data type
      sortRowInt.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));
      sortRowString.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));
      sortRowDate.sort((a,b)=> a.rowFieldList[index].value.compareTo(b.rowFieldList[index].value));

      /// added in the same row list.
      /// now the row is sorted according to sorting logic
      widget.rowsData = [...sortRowEmpty, ...sortRowInt, ...sortRowString, ...sortRowDate];
    }
    else{
      /// reverse the list if the list is already sorted
      /// it gives an asc and desc order sorting technique
      widget.rowsData = widget.rowsData.reversed.toList();
    }
    return slug;
  }

  /// get all edited or changed rows
  /// it only track dropdown and edit text row cell
  List<RowWidgetModel> getEditedRows(){
    List<RowWidgetModel> list = [];
    for(RowWidgetModel row in widget.rowsData){
      for(RowFieldWidgetModel field in row.rowFieldList){
        if(field.type == RowFieldWidgetType.editText){
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
    /// disposing the controller
    if(widget.verticalController == null){
      if(innerVerticalController.hasListeners){
        innerVerticalController.removeListener(() { });
      }
      innerVerticalController.dispose();
    }
    /// calling onSave function in dispose
    if(widget.onSave != null){
      widget.onSave!(getEditedRows());
    }
  }
}
