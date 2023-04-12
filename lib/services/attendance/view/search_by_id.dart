import 'package:churchtick/core/widgets/costum_text_field.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SearchMemberById extends StatefulWidget {
  final Box box;
  SearchMemberById(this.box);
  @override
  _SearchMemberByIdState createState() => _SearchMemberByIdState();
}

class _SearchMemberByIdState extends State<SearchMemberById> {
  int index;
  Map map = Map();
  Box box;
  String input;
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
            textInputType: TextInputType.number,
            hintTitle: 'Search',
            color: Colors.blue[900],
            textChanged: (String value) {
              setState(() {
                input = value;
                index = int.parse(value);
              });
            },
          ),
          input == null || input.isEmpty
              ? Center(
                  child: Text('Enter Id'),
                )
              : index > box.length || index <= 0
                  ? Center(
                      child: Text('Error: Id not found'),
                    )
                  : ListTile(
                      title: Text(box.getAt(index - 1)['name']),
                      subtitle: Text(box.getAt(index - 1)['contact']),
                      trailing: IconButton(
                        icon: Icon(Icons.done_outline),
                        onPressed: () {
                          widget.box
                              .put(box.getAt(index - 1)['id'],
                                  box.getAt(index - 1))
                              .whenComplete(() => Get.snackbar('Done', "Good"));
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
