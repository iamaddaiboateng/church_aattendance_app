import 'dart:convert';

import 'package:churchtick/models/members_model.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class AttendanceController with ChangeNotifier {
  var lazyBox = Hive.box(kMembersTotal);
  var box = Hive.box(kServices);
  String attendanceBox;
  String serviceDate, serviceNameNum;

  setServiceBoxName(String boxName) {
    attendanceBox = boxName;
    notifyListeners();
  }

  getServiceDateDetail(String date) {
    serviceDate = date;
  }

  getServiceName(String name) {
    serviceNameNum = name;
  }

  openAttendance(String name) {
    Hive.openBox(name);
  }

  markAttendance(String name, Map map) {
    var box = Hive.box(name);
    box.add(map);
  }

  getAttendanceInExcel(
      {@required String serviceDate,
      @required serviceBoxName,
      @required serviceNumber}) async {
    var box = Hive.box(serviceBoxName);
    List<MemberModel> attendanceList = [];
    List<List> row = [];

    for (var value in box.values) {
      MemberModel model = MemberModel(
          name: value['name'],
          contact: value['contact'],
          location: value['location']);
      attendanceList.add(model);
    }

    row.add(['Name', "Contact", "Seat Number"]);

    attendanceList.forEach((element) {
      row.add([element.name, element.contact, element.location]);
    });

    var present = ListToCsvConverter().convert(row);
    print(present);

//    var path = await getExternalStorageDirectories();
//    var attendancePath = await new Directory(
//            '${path[0].path}/Church Ticker/attendance/$serviceDate')
//        .create(recursive: true);
//    print(attendancePath);
//    File file = File("${attendancePath.path}/$serviceNumber.xlsx");
//    file
//        .writeAsString(present)
//        .whenComplete(() => Get.snackbar('Done', 'File save successfully'));

    WcFlutterShare.share(
        sharePopupTitle: "Share via",
        fileName: '$serviceNumber $serviceDate.csv',
        mimeType: 'text/csv',
        bytesOfFile: utf8.encode(present));
  }
}
