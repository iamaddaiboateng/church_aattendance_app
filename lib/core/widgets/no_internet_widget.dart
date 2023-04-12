import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(50.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.offline_bolt,
            size: 100.0,
            color: Colors.red,
          ),
          Text(
            "No internet connection \nPlease ensure you have active internet connection",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
