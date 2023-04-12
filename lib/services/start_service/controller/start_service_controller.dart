import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StartService {
  static addServiceToDateService(String serviceName) {
    var serviceBox = Hive.box(serviceName);
    String service = "$kServices ${serviceBox.length + 1}";
    Map map = {kName: service, kReadableTime: DateTime.now()};
    serviceBox.add(map);
  }

  static deleteService(serviceName, index, serviceDetail) {
    var serviceBox = Hive.box(serviceName);
    serviceBox.deleteAt(index);
    Hive.openBox(serviceDetail).whenComplete(() {
      Hive.box(serviceDetail).deleteFromDisk();
    });
  }

  static startServiceDialog(serviceName) {
    Get.dialog(AlertDialog(
      content: Text('Will you like to start a new service?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            addServiceToDateService(serviceName);
            Get.back();
          },
        )
      ],
    ));
  }

  static deleteServiceDialog(serviceName, int index, serviceDetails) {
    Get.dialog(AlertDialog(
      content: Text('Will you like to delete this service?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            deleteService(serviceName, index, serviceDetails);
            Get.back();
          },
        )
      ],
    ));
  }
}
