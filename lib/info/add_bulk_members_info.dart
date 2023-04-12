import 'package:flutter/material.dart';

import 'controller/info_controller.dart';

class AddBulkMemberInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Text(
            "File format",
            style: headerStyle,
          ),
          Text(
              'Church Ticker accepts only CSV files when loading BULK MEMBERS into the database'),
          SizedBox(
            height: 5,
          ),
          Text(
            "How to get a CSV file",
            style: headerStyle,
          ),
          Text('1. Create your membership list in EXCEL'),
          Text("2. Select SAVE AS instead of SAVE when saving you file"),
          Text('3. Change file format to CSV before saving the file'),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Data Structure",
            style: headerStyle,
          ),
          SizedBox(
            height: 5,
          ),
          Text('Your membership data file MUST HAVE THREE COLUMNS. \n'
              'The first Row MUST BE A HEAD (i.e, a row with the title of the fields below them). \n'
              'First column must contain NAMES of members, Second their PHONE NUMBERS and lastly LOCATION'),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.teal,
            textColor: Colors.white,
            child: Text('Get a sample file format'.toUpperCase()),
            onPressed: () {
              getCSVFile();
            },
          )
        ],
      ),
    );
  }
}
