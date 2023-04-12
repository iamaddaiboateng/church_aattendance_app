import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewMembersList extends StatelessWidget {
  final String boxName;
  NewMembersList(this.boxName);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('$kNewMembers$boxName'),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: Container(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save_alt),
              onPressed: () {
                ServiceDetailsController().getAllMemberInExcel(
                    Hive.box('$kNewMembers$boxName'),
                    ' $boxName Added Members');
              },
            ),
            appBar: AppBar(
              title: Text(boxName),
            ),
            body: WatchBoxBuilder(
              box: Hive.box('$kNewMembers$boxName'),
              builder: (context, box) {
                return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(box.getAt(index)['name']),
                        subtitle: Text(box.getAt(index)['contact'].toString()),
                      );
                    });
              },
            ),
          );
        });
  }
}
