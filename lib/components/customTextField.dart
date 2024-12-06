// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final controller;
  final labelText;
  final suffixIcon;
  final obscureText;
  final hintText;
  final helperText;

  CustomTextField({
    required this.labelText,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
    this.hintText,
    this.helperText,
});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          label: Text('${widget.labelText}'),
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    )
    ;
  }
}
