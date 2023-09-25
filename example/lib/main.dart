import 'package:flutter/material.dart';
import 'package:flutter_data_table/flutter_data_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  getColumnList(){
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
          slug: "sku",
          label: "SKU NO",
          orderNumber: 1,
          textAlign: TextAlign.start,
          columnType: RowFieldWidgetType.textWidget
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "line_item_name",
          label: "ITEMS",
          orderNumber: 2,
          columnType: RowFieldWidgetType.textWidget,
          textAlign: TextAlign.start,
          fixedWidth: Responsive.width(20, context!)
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "location_note",
          label: "LOCATION & NOTES",
          orderNumber: 3,
          columnType: RowFieldWidgetType.textWidget,
          textAlign: TextAlign.start,
          fixedWidth: Responsive.width(15, context)
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "quantity",
          label: "QUANTITY",
          orderNumber: 4,
          textAlign: TextAlign.start,
          columnType: RowFieldWidgetType.textWidget
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "unit_markup_cost",
          label: "UNIT COST",
          orderNumber: 5,
          textAlign: TextAlign.start,
          columnType: RowFieldWidgetType.textWidget
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "total_markup_cost",
          label: "TOTAL COST",
          orderNumber: 6,
          textAlign: TextAlign.start,
          columnType: RowFieldWidgetType.textWidget
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "approval_status",
          label: "APPROVAL",
          orderNumber: 7,
          textAlign: TextAlign.start,
          columnType: RowFieldWidgetType.textWidget
      ),
      ColumnHeaderModel(
          id: 1,
          slug: "note",
          label: "CLIENT NOTES",
          orderNumber: 8,
          columnType: RowFieldWidgetType.textWidget,
          textAlign: TextAlign.start,
          fixedWidth: Responsive.width(15, context!)
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Data Table"),
      ),
      body: FlutterDataTable(
        columnModel: columnWidgetModel,
        rowsData: [],


      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
