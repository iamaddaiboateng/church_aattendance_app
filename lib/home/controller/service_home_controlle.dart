import 'package:churchtick/members/view/all_member_page.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ServiceHome with ChangeNotifier {
  var box = Hive.lazyBox(kServiceDate);
  addService(String service) {
    box.add(service).whenComplete(() => Get.back());
  }

  openServiceDate() async {
    DateTime now = DateTime.now();
    Map map = {kReadableTime: now, kActualTime: now.toIso8601String()};
    await box.add(map);
  }

  membershipAlertDialog() {
    Get.dialog(AlertDialog(
      title: Text('No members added'),
      content: Text('Will you like to add members now?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Add Members'),
          onPressed: () {
            Get.to(AllMembers());
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ));
  }

  removeServiceDialog(index) {
    Get.dialog(AlertDialog(
      title: Text('Delete Service'),
      content: Text('Services deleted can not be accessed again.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Delete'),
          onPressed: () {
            box.deleteAt(index).whenComplete(() => Get.back());
          },
        )
      ],
    ));
  }

  addServiceDialog() {
    Get.dialog(AlertDialog(
      title: Text('Confirm action'),
      content: Text("Will you like to start a new Service day?"),
      actions: <Widget>[
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            openServiceDate();
            Get.back();
          },
        )
      ],
    ));
  }
}
