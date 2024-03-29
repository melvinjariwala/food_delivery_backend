// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String title;
  final bool hasTitle;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;

  const CustomTextFormField(
      {Key? key,
      required this.maxLines,
      required this.title,
      required this.hasTitle,
      required this.initialValue,
      required this.onChanged,
      this.onFocusChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          hasTitle
              ? SizedBox(
                  width: 75,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: Focus(
              onFocusChange: onFocusChanged ?? (hasFocus) {},
              child: TextFormField(
                maxLines: maxLines,
                initialValue: initialValue,
                onChanged: onChanged,
                onEditingComplete: () {
                  print('Done');
                },
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
