import 'package:flutter/material.dart';
import 'package:food_delivery_backend/config/responsive.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';

class OpeningHoursSettings extends StatelessWidget {
  final OpeningHours openingHours;
  final Function(bool?)? onCheckboxChanged;
  final Function(RangeValues)? onSliderChanged;
  const OpeningHoursSettings(
      {Key? key,
      required this.openingHours,
      required this.onCheckboxChanged,
      required this.onSliderChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Responsive.isMobile(context) ? 110 : 55;
    EdgeInsets padding = Responsive.isMobile(context)
        ? const EdgeInsets.all(10.0)
        : const EdgeInsets.all(20.0);
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: padding,
      color: Theme.of(context).backgroundColor,
      child: Responsive.isMobile(context)
          ? Column(
              children: [
                Row(
                  children: [
                    _buildCheckbox(context),
                    const SizedBox(width: 10.0),
                    _biuldText(context)
                  ],
                ),
                const SizedBox(height: 10.0),
                Expanded(child: _buildSlider(context)),
              ],
            )
          : Row(
              children: [
                _buildCheckbox(context),
                const SizedBox(width: 10.0),
                Expanded(child: _buildSlider(context)),
                const SizedBox(width: 10.0),
                _biuldText(context)
              ],
            ),
    );
  }

  SizedBox _biuldText(BuildContext context) {
    return SizedBox(
      width: 125,
      child: openingHours.isOpen
          ? Text(
              'Open from ${openingHours.openAt} to ${openingHours.closeAt}',
              style: Theme.of(context).textTheme.headline5,
            )
          : Text(
              'Closed on ${openingHours.day}',
              style: Theme.of(context).textTheme.headline5,
            ),
    );
  }

  Row _buildCheckbox(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: openingHours.isOpen,
          onChanged: onCheckboxChanged,
          activeColor: Theme.of(context).primaryColor,
          fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 100.0,
          child: Text(
            openingHours.day,
            style: Theme.of(context).textTheme.headline5,
          ),
        )
      ],
    );
  }

  RangeSlider _buildSlider(BuildContext context) {
    return RangeSlider(
      divisions: 24,
      values: RangeValues(openingHours.openAt, openingHours.closeAt),
      min: 0,
      max: 24,
      onChanged: onSliderChanged,
    );
  }
}
