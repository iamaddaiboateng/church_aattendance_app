import 'package:churchtick/members/view/new_members_list.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox(kNewMembers),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('New Members'),
          ),
          body: WatchBoxBuilder(
            box: snapshot.data,
            builder: (context, box) => box.isEmpty
                ? Center(
                    child: Text('No record of new members found'),
                  )
                : ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewMembersList(box.getAt(index));
                              },
                            ),
                          );
                        },
                        title: Text(box.getAt(index)),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
