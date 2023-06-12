import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> items;
  final Function(String?)? onChanged;
  const CustomDropDownButton(
      {Key? key, required this.items, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 45,
        child: DropdownButtonFormField(
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {}),
      ),
    );
  }
}
