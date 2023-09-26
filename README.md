### Features

- Support Android, IOS.
- This package is used to create a complete customizable and dynamic data table;
- Works fine on any Widget;
- Does not affect the functionality or performance of the application;
- This table has a dynamic sort function which add a sort functionality to the data table and it can sort any type of data in the table and re-arrange the table according to it;


## Demo
**Without auto sort functionality on**
Initially "sort" is false.
```
    isSortAllowed = false
```
![](https://raw.githubusercontent.com/Smueez/assets/main/floating_widget.gif)

**Sort functionality activated**
Add this to your code.
```
    isSortAllowed = false
```
![](https://raw.githubusercontent.com/Smueez/assets/main/autoAlign.gif)

### Getting started

####  Install
add this in your pubspec.yaml
`flutter_data_table: ^latest_version`

#### Class

This is the constructor of the class.
```
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
        this.isSortAllowed = false
      });
```
### Where:

-  **columnModel** is required and it is a **ColumnWidgetModel** type. This is the column model class.
-  **rowsData** is also required and it is a list of **RowWidgetModel** type. This is the list of the rows of the table.
-  **colors** is a **RowColor** type. To separate 2 adjacent row by 2 different color.
-  **isCheckBoxMultiSelectAllowed** is a **boolean** value indicates if multiselect rows allowed with checkbox.
-  **sort** is a **Function**. This gives a global sort mechanism for the data table. This is not mandatory as the table has it's own dynamic sort mechanism.
-  **padding** is a **EdgeInsetsGeometry** type which gives a padding for the data table.
-  **isLoadMoreDataAllowed** is a **double** value. By making this True, data table will get an infinite scroll.
-  **onLoadMoreData** is a **Function**. This function will be called when the data table reach the end of the scroll and if **isLoadMoreDataAllowed** is True.
-  **rowHeight** is a **double** value. Which gives all the row a fixed height.
-  **isDraggable** accepts a **boolean** value which determines if the widget is draggable or not.
-  **autoAlign** accepts a **boolean** value which determines if the widget will be auto aligns on the left or right after it is being dragged.
-  **deleteWidget** accepts a **widget** which is used to delete the floating widget.
-  **onDeleteWidget** accepts a **function** which is used to delete the floating widget.
-  **deleteWidgetAlignment** accepts an **alignment** value which is used to align the delete widget.
-  **deleteWidgetAnimationCurve** accepts an **animation curve** value which is used to animate the delete widget.
-  **deleteWidgetAnimationDuration** accepts an **animation duration** value which is used to animate the delete widget
-  **hasDeleteWidgetAnimationDuration** accepts an **animation duration** value which is used to animate the delete widget when it is dragging with the delete widget.
-  **deleteWidgetHeight** accepts a **double** value which is used to set the height of the delete widget.
-  **deleteWidgetWidth** accepts a **double** value which is used to set the width of the delete widget.
-  **isCollidingDeleteWidgetHeight** accepts a **double** value which is used to set the height of the delete widget.
-  **isCollidingDeleteWidgetWidth** accepts a **double** value which is used to set the width of the delete widget.
-  **boxDecoration** optionally accepts a box **decoration** value which is used to set the decoration of the delete widget.
-  **deleteWidgetPadding** optionally accepts a **padding** value which is used to set the padding of the delete widget.
#### Usage　

```Dart
import 'package:flutter/material.dart';
import 'package:floating_animated_widget/floating_draggable_widget.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return FloatingDraggableWidget(
      child: Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingWidget: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingWidgetHeight: 40,
      floatingWidgetWidth: 40,
      dx: 200,
      dy: 300
    );
  }
}

```
### Known Limitations
- Doesn't have functionality of floating on other apps.
- It does not automatically calculate the size of the parent widget it always takes the whole screen to float around.
- It does not automatically calculate the size of the floating widget
### End
