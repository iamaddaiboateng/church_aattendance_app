import 'package:flutter/material.dart';

class FormSizeContainer extends StatelessWidget {
  final Widget child;
  FormSizeContainer({@required this.child});
  @override
  Widget build(BuildContext context) {

     bool wide = MediaQuery.of(context).size.width > 400.0;
     double fullWidget = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: wide ? 380.0 : fullWidget,
        child: Center(child: child),
      ),
    );
  }
}