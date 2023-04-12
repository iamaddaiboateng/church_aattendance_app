import 'package:churchtick/info/controller/info_controller.dart';
import 'package:churchtick/members/add_member_page/add_single_member.dart';
import 'package:churchtick/services/attendance/view/search_by_name.dart';
import 'package:churchtick/services/report/views/service_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AttendancePage extends StatefulWidget {
  final String boxName;
  AttendancePage(this.boxName);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox(widget.boxName),
      builder: (context, snapshot) {
        print(widget.boxName);
        if (snapshot.data == null)
          return Center(
            child: Container(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
        return Scaffold(
            bottomNavigationBar: Container(
              height: 50.0,
              child: WatchBoxBuilder(
                box: snapshot.data,
                builder: (context, box) => Center(
                    child: Text(
                  '${snapshot.data.length}  member(s) present',
                  style: headerStyle,
                )),
              ),
            ),
            appBar: AppBar(
              title: Text('Attendance'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print(widget.boxName);
                    Get.to(AddSingleUserPage());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.event_note),
                  onPressed: () {
                    print(widget.boxName);
                    Get.to(ServiceReport(widget.boxName));
                  },
                )
              ],
            ),
            body: SearchMembersByName(Hive.box(widget.boxName)));
      },
    );
  }
}
