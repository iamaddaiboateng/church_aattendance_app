import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

getCSVFile() {
  List<List> rows = [];
  // add data to you list of list
  rows.add(['Name', 'Phone Number', 'Location']);
  // convert list of list into a csv file
  var csvFile = ListToCsvConverter().convert(rows);
  // share file using WcFlutterShare
  WcFlutterShare.share(
      sharePopupTitle: 'Share via', // name on pop up
      fileName: 'Church Ticker File Format.csv', // title of the file to share
      mimeType: 'text/csv', // file format to share
      bytesOfFile: utf8.encode(csvFile)); // convert csv string to byte
}

TextStyle headerStyle =
    TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
