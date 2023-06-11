// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String title;
  final bool hasTitle;
  final String initialValue;
  final Function(String)? onChanged;
  const CustomTextFormField(
      {Key? key,
      required this.maxLines,
      required this.title,
      required this.hasTitle,
      required this.initialValue,
      required this.onChanged})
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
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}