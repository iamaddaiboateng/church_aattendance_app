import 'package:churchtick/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CreateService with ChangeNotifier {
  var memberBox = Hive.box(kMembersTotal);
  var serviceBox = Hive.box(kServices);
  var services;
  List allMembers = [], tempList = [];
  List<List> newList = [];
  createServicesFromMembers() {}

  String getServiceNumber(int index) {
    return services = "$kServices ${serviceBox.length + index}";
  }

  clearList() {
    newList.clear();
    notifyListeners();
  }

  splitList(int range) async {
    tempList =
        List.generate(memberBox.length, (index) => memberBox.getAt(index));

    for (var item in tempList) {
      var member = await memberBox.getAt(tempList.indexOf(item));
      allMembers.add(member);
    }
    if (newList.isEmpty)
      for (int i = 0; i < allMembers.length; i += range) {
        if (i + range < allMembers.length) {
          newList.add(allMembers.sublist(i, i + range));
          notifyListeners();
        } else {
          newList.add(allMembers.sublist(i));
          notifyListeners();
        }
      }
    else
      newList.clear();
    notifyListeners();
    print(newList);
  }

  saveAll(serviceName) {
    for (var item in newList) {
      addListOfServices(item, serviceName);
    }
    newList.clear();
    print(newList);
  }

  addListOfServices(List items, serviceName) async {
    await Hive.openLazyBox(serviceName);
    serviceBox.add(serviceName);
    // print(newList[index]);
    for (var item in items) {
      //print(item);
      await Hive.lazyBox(serviceName).add(item).whenComplete(
        () {
          print(item);
          print(items);
          if (items.isEmpty) {
            newList.remove(item);
            notifyListeners();
          }
        },
      );
    }
  }
}

class SplitList {
  var memberBox = Hive.lazyBox(kMembersTotal);
  List allMembers = [], tempList = [];
  List<List> newList = [];
  var serviceBox = Hive.box(kServices);
  splitList(int range) async {
    tempList =
        List.generate(memberBox.length, (index) => memberBox.getAt(index));

    for (var item in tempList) {
      var member = await memberBox.getAt(tempList.indexOf(item));
      allMembers.add(member);
    }

    for (int i = 0; i < allMembers.length; i += range) {
      if (i + range < allMembers.length) {
        newList.add(allMembers.sublist(i, i + range));
      } else {
        newList.add(allMembers.sublist(i));
      }
    }
    //print(newList);
    return newList;
  }

  addListOfServices(int index, serviceName, newList) async {
    await Hive.openLazyBox(serviceName);
    serviceBox.add(serviceName);
    // print(newList[index]);
    for (var item in newList[index]) {
      //print(item);
      await Hive.lazyBox(serviceName).add(item).whenComplete(
        () {
          print(item);
          print(newList[index]);
          if (newList[index].isEmpty) {
            newList.removeAt(index);
          }
        },
      );
    }
  }
}
