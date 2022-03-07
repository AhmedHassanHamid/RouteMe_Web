import 'package:flutter/material.dart';
import 'package:web/Model/Drivers/driver.dart';
import 'package:web/Pages/vendors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DriverDataSource extends DataGridSource {
  DriverDataSource(
      {required List<DriversModel> drivers, required this.context}) {
    _drivers = drivers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'email', value: e.name),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<Map<String, dynamic>>(
                  columnName: 'actions', value: e.actions),
            ]))
        .toList();
  }

  List<DataGridRow> _drivers = [];
  BuildContext context;

  @override
  List<DataGridRow> get rows => _drivers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: e.columnName == "actions"
            ? FittedBox(
                child: Row(
                  children: [
                    if (e.value['edit'])
                      FittedBox(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Vendors()));
                              },
                              icon: Icon(Icons.edit))),
                    if (e.value['delete'])
                      FittedBox(
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete))),
                  ],
                ),
              )
            : Text(
                e.value.toString(),
                style: TextStyle(
                    color:
                        e.columnName == "status" ? Colors.green : Colors.black),
              ),
      );
    }).toList());
  }
}
