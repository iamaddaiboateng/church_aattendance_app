import 'dart:convert';
import 'dart:io';

import 'package:churchtick/members/add_member_page/add_bulk_member.dart';
import 'package:churchtick/members/add_member_page/add_single_member.dart';
import 'package:churchtick/models/members_model.dart';
import 'package:churchtick/utils/date_time.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ServiceDetailsController with ChangeNotifier {
  var memberBox = Hive.box(kMembersTotal);
  var newMember = Hive.openBox(kNewMembers);
  var dateBox = Hive.lazyBox(kServiceDate);
  var newUserId;
  bool inProgress = false;
  File csvFile;
  var serviceName;
  var serviceAttendanceTotalName;
  List<MemberModel> members = [];
  List<List<dynamic>> personnelList = [];
  String date = kPickDate;
  DateTime pickedDate;

  // membership status var
  List<String> membershipLabels = ['MEMBER', 'VISITOR'];

  // cells
  List<String> cells = [
    'KUNKA NEW SITE',
    'NANA PONKO',
    'NEW BAIKOYEDEN',
    'COUNCIL QUARTERS',
    'KYEKYEWERE',
    'KWABRAFOSO',
    'BRAHABEBOME',
    'KAPA',
    'MONSEY VALLEY',
    'BRUNO/SAM JONAH',
    'MENSAKROM',
    'ESTATE',
    'TINY ROWLAND',
    'KULEM'
  ];

  // marital status
  List<String> marriageStatus = ['SINGLE', 'MARRIED'];

  String marriage = 'SINGLE';

  setMaritalStatus(String married) {
    marriage = married;
    notifyListeners();
  }

  // set cell
  String memberCell = noCellSelected;

  String memberStatusLabel = 'MEMBER';

  // gender status var
  List<String> genderLabels = ['MALE', 'FEMALE'];
  String genderStatusLabel = 'MALE';

  changeGenderStatus(String label) {
    genderStatusLabel = label;
    notifyListeners();
  }

  //select cell
  selectCell(String newCell) {
    memberCell = newCell;
    notifyListeners();
  }

  //select bible study
  String bibleStudy = '';

  selectBibleStudy(String newCell) {
    bibleStudy = newCell;
    notifyListeners();
  }

  getServiceName(String newServiceName) {
    serviceName = newServiceName;
    notifyListeners();
  }

  getServiceTotalAttendanceName(String newServiceName) {
    serviceAttendanceTotalName = '$newServiceName total';
    Hive.openBox(serviceAttendanceTotalName);
    notifyListeners();
  }

  openDateService(String serviceName) {
    Hive.openBox(serviceName);
  }

  changeMemberShipStatus(String changedStatus) {
    memberStatusLabel = changedStatus;
    print(memberStatusLabel);
    notifyListeners();
  }

  openServiceDate() async {
    DateTime now = DateTime.now();
    Map map = {kReadableTime: now, kActualTime: now.toIso8601String()};
    await dateBox.putAt(0, map);
  }

  getNewUserId() async {
    if (await memberBox.get('lastNumber') == null) {
      newUserId = 1;
      notifyListeners();
      await memberBox.put('lastNumber', newUserId);
    } else {
      newUserId = await memberBox.get('lastNumber') + 1;
      notifyListeners();
      await memberBox.put('lastNumber', newUserId);
    }
  }

  //pick date of birth
  pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: pickedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null) {
      pickedDate = picked;
      date = getDateInString(picked);
      notifyListeners();
    }
  }

  addSingleMembers(
    MemberModel model,
    TextEditingController nameController,
    TextEditingController contactController,
    TextEditingController locationController,
    TextEditingController spouseController,
    TextEditingController noChildController,
    TextEditingController occupationController,
    TextEditingController otherHouseHoldController,
    TextEditingController contactPersonController,
  ) {
    // get reference to new members box
    var members = Hive.box(kNewMembers);
    // get date the member is being added
    String timeDate = getDateInString(DateTime.now());
    // add time to list of new members
    members.put(timeDate, timeDate);
    // open the box to add new members

    inProgress = true;
    notifyListeners();

    var filter = memberBox.values.where((element) =>
        element['name'] == nameController.text &&
        element['contact'] == contactController.text);
    print(filter);
    if (filter.isEmpty) {
      memberBox.add(model.toMap()).whenComplete(() {
        // add member to new members list
        Hive.openBox('$kNewMembers$timeDate').whenComplete(() {
          Hive.box('$kNewMembers$timeDate')
              .put(memberBox.length + 1, model.toMap())
              .whenComplete(() {
            Get.snackbar('Success', 'Member added Successfully');
            memberStatusLabel = '';
            genderStatusLabel = '';
            memberCell = '';
            marriage = '';
            date = kPickDate;
            notifyListeners();
          });
        });

        inProgress = false;
        nameController.clear();
        contactController.clear();
        locationController.clear();
        spouseController.clear();
        noChildController.clear();
        occupationController.clear();
        contactPersonController.clear();
        otherHouseHoldController.clear();
        notifyListeners();
      });
    } else {
      Get.snackbar('Error', "Member already exist in the database",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      inProgress = false;
      notifyListeners();
    }
  }

  addBulkMembers() {
    inProgress = true;
    List alreadyListed = [];
    notifyListeners();
    for (var member in members) {
      //countBox.put('lastNumber', newUserId);
      var filter = memberBox.values.where((element) =>
          element['name'] == member.name &&
          element['contact'] == member.contact);

      if (filter.isEmpty) {
        memberBox.put(memberBox.length + 1, member.toMap()).whenComplete(() {
          members.removeAt(members.indexOf(member));
          if (members.isEmpty) {
            alreadyListed.add(member);
            inProgress = false;
            Get.snackbar('Successful', 'Members Added Successfully');
          }
          notifyListeners();
        });
      } else {
        if (members.indexOf(member) + 1 == members.length) {
          // if (members.isNotEmpty) {
          Get.defaultDialog(
            confirm: FlatButton(
              textColor: Colors.teal,
              child: Text('Continue'),
              onPressed: () {
                members.clear();
                Get.back();
                notifyListeners();
              },
            ),
            onConfirm: () {
              print('I did something');
            },
            content: Text(
                '${members.length} members are already present in the database.'),
          );
        }
        inProgress = false;
        notifyListeners();
      }
    }
  }

  // pickCSVFile() async {
  //   //check permission
  //   var status = await Permission.storage.status;
  //   print(status);
  //
  //   if (status == PermissionStatus.granted) {
  //     // pick file from device
  //     csvFile = await FilePicker.getFile(
  //         type: FileType.custom, allowedExtensions: ['csv']);
  //   } else if (status == PermissionStatus.denied) {
  //     await Permission.storage.request().whenComplete(() async {
  //       if (await Permission.storage.status.isGranted) {
  //         csvFile = await FilePicker.getFile(
  //             type: FileType.custom, allowedExtensions: ['csv']);
  //       }
  //     });
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     openAppSettings();
  //   } else if (status == PermissionStatus.undetermined) {
  //     await Permission.storage.request();
  //   } else if (status == PermissionStatus.restricted) {
  //     openAppSettings();
  //   }
  //
  //   // clear models before adding new list to ensure list do not repeat
  //   if (csvFile != null) {
  //     members.clear();
  //     notifyListeners();
  //   }
  //
  //   if (csvFile != null) {
  //     //  print(csvFile.readAsBytes());
  //
  //     personnelList =
  //         CsvToListConverter().convert(await csvFile.readAsString());
  //     for (int i = 0; i <= personnelList.length - 1; i++) {
  //       if (i != 0) {
  //         MemberModel model = MemberModel(
  //             name: personnelList[i][1].toString(),
  //             id: memberBox.length + i,
  //             dateOfBirth: personnelList[i][2].toString(),
  //             gender: personnelList[i][3].toString(),
  //             cell: personnelList[i][6].toString(),
  //             bibleStudies: personnelList[i][7].toString(),
  //             maritalStatus: personnelList[i][8].toString(),
  //             nameOfSpouse: personnelList[i][9].toString(),
  //             noChildren: personnelList[i][10].toString(),
  //             otherHouseHold: personnelList[i][11].toString(),
  //             occupation: personnelList[i][12].toString(),
  //             contactPerson: personnelList[i][13].toString(),
  //             contact: numberWithCountryCode(personnelList[i][5].toString()),
  //             location: personnelList[i][4].toString());
  //
  //         members.add(model);
  //         notifyListeners();
  //       }
  //     }
  //   }
  // }

  addMemberDialog() {
    Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            child: Text("Add single member"),
            onPressed: () {
              Get.off(AddSingleUserPage());
            },
          ),
          TextButton(
            child: Text("Add bulk member"),
            onPressed: () {
              Get.off(AddBulkMembers());
            },
          )
        ],
      ),
    ));
  }

  editMembersDetails({
    MemberModel model,
    TextEditingController nameController,
    TextEditingController contactController,
    TextEditingController locationController,
    TextEditingController spouseController,
    TextEditingController noChildController,
    TextEditingController occupationController,
    TextEditingController otherHouseHoldController,
    TextEditingController contactPersonController,
  }) {
    inProgress = true;
    notifyListeners();
    memberBox.putAt(model.id, model.toMap()).whenComplete(() {
      Get.back();
      Get.snackbar('Success', 'Member edited Successfully');
      inProgress = false;
      memberStatusLabel = '';
      genderStatusLabel = '';
      memberCell = '';
      marriage = '';
      date = kPickDate;
      nameController.clear();
      contactController.clear();
      locationController.clear();
      spouseController.clear();
      noChildController.clear();
      occupationController.clear();
      contactPersonController.clear();
      otherHouseHoldController.clear();
      notifyListeners();
    });
  }

  getAllMemberInExcel(Box box, String name) async {
    //var box = Hive.box(kMembersTotal);

    List<MemberModel> attendanceList = [];
    List<List> row = [];

    for (var value in box.values) {
      MemberModel modelMap = MemberModel.fromMap(value);
      attendanceList.add(modelMap);
    }

    row.add([
      'Name',
      "Contact",
      "Location",
      'Gender',
      'Cell',
      'Bible Study',
      kDateOfBirth,
      kLocation,
      kMarriageStatus,
      kNameOfSpouse,
      kNoChildren,
      kOccupation,
      kOtherHouseHold,
      kContactPerson
    ]);

    attendanceList.forEach((element) {
      row.add([
        element.name,
        element.contact,
        element.location,
        element.gender,
        element.cell,
        element.bibleStudies,
        element.dateOfBirth,
        element.location,
        element.maritalStatus,
        element.nameOfSpouse,
        element.noChildren,
        element.occupation,
        element.otherHouseHold,
        element.contactPerson
      ]);
    });

    var present = ListToCsvConverter().convert(row);

    print(present);

    WcFlutterShare.share(
        sharePopupTitle: "Share via",
        fileName: '$name.csv',
        mimeType: 'text/csv',
        bytesOfFile: utf8.encode(present));
  }

  //share file
  shareFile([String fileName, File file]) {}
}
