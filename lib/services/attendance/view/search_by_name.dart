import 'package:churchtick/core/widgets/costum_text_field.dart';
import 'package:churchtick/members/add_member_page/edit_members_details.dart';
import 'package:churchtick/models/members_model.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SearchMembersByName extends StatefulWidget {
  final Box box;
  SearchMembersByName([this.box]);
  @override
  _SearchMembersByNameState createState() => _SearchMembersByNameState();
}

class _SearchMembersByNameState extends State<SearchMembersByName> {
  Box box;
  String name;
  var query = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      box = Hive.box(kMembersTotal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CustomTextField(
            textInputType: TextInputType.text,
            hintTitle: 'Search',
            textChanged: (String value) {
              setState(() {
                name = value;
                query.clear();
                Iterable filter = box.values.where((member) {
                  return member['name']
                      .toLowerCase()
                      .contains(value.toLowerCase());
                });
                filter.forEach((element) {
                  query.add(element);
                });
                print(query.length);
              });
            },
            color: Colors.teal[900],
          ),
          name == null || name.isEmpty
              ? Center(
                  child: Text('Enter name'),
                )
              : query.isEmpty
                  ? Center(
                      child: Text('No member found'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: query.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditMembersDetailsPage(
                                            MemberModel.fromMap(
                                                query[index]))));
                          },
                          leading: Text('${query[index]['location']}'),
                          title: Text(query[index]['name']),
                          subtitle: Text(query[index]['contact']),
                          trailing: IconButton(
                            icon: Icon(Icons.done_outline),
                            onPressed: () {
                              var filter = widget.box.values.where((element) =>
                                  element['name'] == query[index]['name'] &&
                                  element['contact'] ==
                                      query[index]['contact']);
                              if (filter.isEmpty)
                                widget.box.add(query[index]).whenComplete(
                                    () => Get.snackbar('Done', "Good"));
                              else
                                Get.snackbar('Error', 'Member already marked');
                            },
                          ),
                        );
                      },
                    )
        ],
      ),
    );
  }
}
