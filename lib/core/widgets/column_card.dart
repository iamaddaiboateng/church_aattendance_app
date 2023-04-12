import 'package:flutter/material.dart';

class ColumnCard extends StatelessWidget {
  final Widget rowChildOne;
  final Widget rowChildTwo;
  final Widget child;

  ColumnCard(
      {@required this.rowChildOne, this.rowChildTwo, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[rowChildOne, rowChildTwo ?? Container()],
            ),
            Divider(),
            child
          ],
        ),
      ),
    );
  }
}
