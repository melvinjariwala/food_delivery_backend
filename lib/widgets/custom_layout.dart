// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery_backend/config/responsive.dart';

class CustomLayout extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  const CustomLayout({super.key, required this.title, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headline3),
                  const SizedBox(height: 20.0),
                  ...widgets,
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 75),
                    color: Theme.of(context).backgroundColor,
                    child: const Center(child: Text("Advertisements")),
                  )
                ],
              ),
            ),
          ),
        ),
        Responsive.isWideDesktop(context) || Responsive.isDesktop(context)
            ? Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 20.0),
                  color: Theme.of(context).colorScheme.background,
                  child: const Center(child: Text("Advertisements")),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
