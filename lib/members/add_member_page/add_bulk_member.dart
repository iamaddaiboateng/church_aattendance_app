import 'package:churchtick/info/add_bulk_members_info.dart';
import 'package:churchtick/members/controller/members_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddBulkMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceDetailsController>(
      builder: (_, members, __) => ModalProgressHUD(
        inAsyncCall: members.inProgress,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // members.pickCSVFile();
            },
          ),
          appBar: AppBar(
            title: Text('Add Bulk Members'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  members.members.isNotEmpty
                      ? members.addBulkMembers()
                      : Get.snackbar('Error', 'No Member added');
                },
              )
            ],
          ),
          body: members.members.isEmpty
              ? AddBulkMemberInfo()
              : ListView.builder(
                  itemCount: members.members.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Text(members.members[index].id.toString()),
                      title: Text(members.members[index].name),
                      subtitle: Text(members.members[index].contact),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
