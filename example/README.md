# Example

```Dart
import 'package:flutter/material.dart';
import 'package:flutter_data_table/flutter_data_table.dart';
import 'package:flutter_data_table/models/custom_table_dropdown_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Table',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Flutter Data Table Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ColumnWidgetModel columnWidgetModel;
  List<RowWidgetModel> rows = [];
  ColumnWidgetModel getColumnList(){
    List<ColumnHeaderModel> columnList = [
      ColumnHeaderModel(
          id: 1,
          slug: "sl_no",
          label: "SL NO",
          orderNumber: 0,
          textAlign: TextAlign.center,
          columnType: RowFieldWidgetType.textWidget,
          fixedWidth: 20
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "name",
          label: "Name",
          orderNumber: 1,
          columnType: RowFieldWidgetType.textWidget,
          // fixedWidth: 100
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "income",
          label: "Income",
          orderNumber: 2,
          columnType: RowFieldWidgetType.currency,
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "location",
          label: "Location",
          orderNumber: 3,
          columnType: RowFieldWidgetType.clickable,
          // fixedWidth: 100
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "quantity",
          label: "QUANTITY",
          orderNumber: 4,
          columnType: RowFieldWidgetType.editText
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "gender",
          label: "Gender",
          orderNumber: 5,
          columnType: RowFieldWidgetType.dropdown
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "image",
          label: "Image",
          orderNumber: 6,
          columnType: RowFieldWidgetType.customWidget,
          textAlign: TextAlign.center
      )
    ];
    return ColumnWidgetModel(
        columnsList: columnList,
        isSortable: false,
        checkBoxWidgetModel: CheckBoxWidgetModel(
          side: const BorderSide(color: Colors.white),
          activeColor: Colors.transparent,
          checkColor: Colors.white,

        )
    );
  }
  setRow(){
    RowWidgetModel row1 = RowWidgetModel(
        rowFieldList: [
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[0],
              value: 1
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[1],
              value: "Shakib Al Hasan"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[2],
              value: "700k"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[3],
              value: "Rangpur"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[4],
              value: ""
          ),

          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[5],
              value: null,
            options: [
              CustomTableDropDownModel(label: "Male"),
              CustomTableDropDownModel(label: "Female"),
              CustomTableDropDownModel(label: "Others")
            ]
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[6],
              value: const Icon(Icons.person, color: Colors.grey,)
          ),
        ]
    );

    RowWidgetModel row2 = RowWidgetModel(
        rowFieldList:  [
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[0],
              value: 2
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[1],
              value: "Mushfiqur Rahim"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[2],
              value: "160k"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[3],
              value: "Dhaka"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[4],
              value: ""
          ),

          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[5],
              value: CustomTableDropDownModel(label: "Male"),
              options: [
                CustomTableDropDownModel(label: "Male"),
                CustomTableDropDownModel(label: "Female"),
                CustomTableDropDownModel(label: "Others")
              ]
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[6],
              value: const Icon(Icons.person, color: Colors.grey,)
          ),
        ]
    );

    RowWidgetModel row3 = RowWidgetModel(
        rowFieldList: [
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[0],
              value: 1
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[1],
              value: "Tamim Iqbal"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[2],
              value: "200k"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[3],
              value: "Chottogram"
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[4],
              value: ""
          ),

          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[5],
              value: null,
              options: [
                CustomTableDropDownModel(label: "Male"),
                CustomTableDropDownModel(label: "Female"),
                CustomTableDropDownModel(label: "Others")
              ]
          ),
          RowFieldWidgetModel(
              columnHeaderModel: columnWidgetModel.columnsList[6],
              value: const Icon(Icons.person, color: Colors.grey,)
          ),
        ]
    );

    rows = [row1, row2, row3];
  }

  @override
  void initState() {
    super.initState();
    columnWidgetModel = getColumnList();
    setRow();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Data Table"),
      ),
      body: FlutterDataTable(
        columnModel: columnWidgetModel,
        rowsData: rows,

      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```
