import 'package:churchtick/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintTitle;
  final String labelTitle;
  final bool isHidden;
  final TextEditingController controller;
  final TextInputType textInputType;
  final int maxLine;
  final Function textChanged;
  final Function textSubmit;
  final TextCapitalization textCapitalization;
  final Color color;

  CustomTextFormField(
      {this.hintTitle,
      this.color = Colors.white,
      this.textChanged,
      this.textSubmit,
      this.labelTitle,
      this.isHidden = false,
      this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine,
      this.textCapitalization = TextCapitalization.sentences});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: textCapitalization,
        onChanged: textChanged,
        style: TextStyle(color: color),
        keyboardType: textInputType,
        maxLines: maxLine,
        onFieldSubmitted: textSubmit,
        obscureText: isHidden,
        controller: controller,
        validator: (String value) {
          if (value.isEmpty) {
            return kRequired;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: hintTitle,
          labelText: labelTitle,
          focusColor: Colors.white,
          hintStyle: TextStyle(color: color),
          hoverColor: color,
          labelStyle: TextStyle(color: color),
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
//          border: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(5.0),
//          ),
        ),
      ),
    );
  }
}
