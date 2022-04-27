import 'dart:developer';

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? searchValue;
  final String? hint;
  final Function? clearEvent;
  final Function? onChangeEvent;
  final Icon? prefixIcon;

  // ignore: use_key_in_widget_constructors
  const SearchField({
    this.controller,
    this.hint,
    this.clearEvent,
    this.prefixIcon,
    this.searchValue,
    this.onChangeEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          onChangeEvent!(value);
        },
        obscureText: false,
        style: const TextStyle(
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.black45,
          ),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: searchValue != ''
              ? IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 12.0,
                    ),
                    onPressed: clearEvent!(),
                  ),
                )
              : null,
          prefixIcon: IconTheme(
            data: const IconThemeData(
              color: Colors.black54,
            ),
            child: prefixIcon!,
          ),
        ),
      ),
    );
  }
}
