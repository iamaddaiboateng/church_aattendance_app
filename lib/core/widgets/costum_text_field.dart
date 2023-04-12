import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintTitle;
  final String labelTitle;
  final bool isHidden;
  final TextEditingController controller;
  final TextInputType textInputType;
  final int maxLine;
  final Function textChanged;
  final Function submitValue;
  final Color color;
  final Icon prefix;

  CustomTextField(
      {this.hintTitle,
      this.submitValue,
      this.color = Colors.teal,
      this.textChanged,
      this.labelTitle,
      this.isHidden = false,
      this.controller,
      this.prefix,
      this.textInputType = TextInputType.text,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: textChanged,
        keyboardType: textInputType,
        maxLines: maxLine,
        obscureText: isHidden,
        controller: controller,
        onSubmitted: submitValue,
        decoration: InputDecoration(
          prefixIcon: prefix,
          focusColor: color,
          hintStyle: TextStyle(color: color),
          hoverColor: color,
          labelStyle: TextStyle(color: color),
          hintText: hintTitle,
//          focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: color),
//            borderRadius: BorderRadius.circular(5.0),
//          ),
//          errorBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.red),
//            borderRadius: BorderRadius.circular(5.0),
//          ),
//          enabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: color),
//            borderRadius: BorderRadius.circular(5.0),
//          ),
          labelText:
              labelTitle == null && hintTitle != null ? hintTitle : labelTitle,
//          border: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.white),
//            borderRadius: BorderRadius.circular(5.0),
//          ),
        ),
      ),
    );
  }
}
