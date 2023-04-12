import 'package:churchtick/info/controller/info_controller.dart';
import 'package:churchtick/members/add_member_page/edit_members_details.dart';
import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/members/view/new_members.dart';
import 'package:churchtick/models/members_model.dart';
import 'package:churchtick/services/attendance/view/search_by_name.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box(kMembersTotal);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        onPressed: () {
          box.isEmpty
              ? Get.snackbar('Error', 'No members added')
              : ServiceDetailsController()
                  .getAllMemberInExcel(Hive.box(kMembersTotal), 'All Members');
        },
      ),
      appBar: AppBar(
        title: Text("All Members"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ServiceDetailsController().addMemberDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewMembers();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchMembersByName();
              }));
            },
          ),
        ],
      ),
      body: WatchBoxBuilder(
        box: box,
        builder: (context, box) {
          return box.isEmpty
              ? Center(
                  child: Text('No Members added'),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          var map = box.getAt(index);
                          return ListTile(
                            onTap: () {
                              MemberModel model = MemberModel.fromMap(map);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditMembersDetailsPage(model);
                              }));
                            },
                            title: Text(map['name'].toString()),
                            leading: Text("${index + 1}"),
                            subtitle: Text(map['id'].toString()),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 50.0,
                      color: Colors.teal,
                      child: Center(
                        child: Text(
                          '${box.length} members added',
                          style: headerStyle,
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
