import 'package:churchtick/info/controller/info_controller.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';

class HomePageWithDataInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  kNoServiceDateAdded,
                  style: headerStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Text('Tap on '),
                    CircleAvatar(
                      radius: 10.0,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    Expanded(
                        child: Text(' at the right-bottom corner to start')),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, height: 1.5),
                        children: [
                      TextSpan(text: 'You may also tap on '),
                      WidgetSpan(
                        child: CircleAvatar(
                            radius: 10.0,
                            child: Icon(
                              Icons.people,
                              size: 15,
                            )),
                      ),
                      TextSpan(
                          text:
                              ' icon at the top-right corner to add members to the database')
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
