import 'package:churchtick/services/attendance/controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ServiceReport extends StatelessWidget {
  final String boxName;
  ServiceReport(this.boxName);
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceController>(context);
    var box = Hive.box(boxName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              AttendanceController().getAttendanceInExcel(
                  serviceBoxName: boxName,
                  serviceDate: attendanceProvider.serviceDate,
                  serviceNumber: attendanceProvider.serviceNameNum);
            },
          )
        ],
      ),
      body: box.isEmpty
          ? Center(
              child: Text('No Member Added'),
            )
          : WatchBoxBuilder(
              box: box,
              builder: (context, box) {
                return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var map = box.getAt(index);
                      return ListTile(
                        leading: CircleAvatar(
                            radius: 15.0, child: Text('${index + 1}')),
                        title: Text(map['name']),
                        subtitle: Text(map['contact']),
                      );
                    });
              },
            ),
    );
  }
}
