// Import the material package
import 'package:flutter/material.dart';

// Define some constants for the colors and sizes
const kTextColor = Colors.white;
const kTextFontSize = 18.0;
const kTextFontWeight = FontWeight.bold;

const kIconColor = Colors.white;
const kIconSize = 24.0;

const kContainerColor = Color.fromARGB(255, 10, 184, 239);
const kContainerBorderRadius = 8.0;
const kContainerBoxShadowColor = Colors.black26;
const kContainerBoxShadowBlurRadius = 5.0;
const kContainerBoxShadowOffsetX = 2.0;
const kContainerBoxShadowOffsetY = 2.0;
const kContainerPadding = 8.0;

const kDropdownElevation = 8;
const kDropdownShapeBorderRadius = 8.0;
const kDropdownColor = Colors.blueGrey;

const kSizedBoxWidth = 150.0;

// Define a custom widget for the date
class DateWidget extends StatelessWidget {
  final String selectedDateRange;
  final Function(String?) onChanged;

  const DateWidget({
    Key? key,
    required this.selectedDateRange,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: kSizedBoxWidth,
      child: Container(
        padding: const EdgeInsets.all(kContainerPadding),
        decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.circular(kContainerBorderRadius),
          boxShadow: const [
            BoxShadow(
              color: kContainerBoxShadowColor,
              blurRadius: kContainerBoxShadowBlurRadius,
              offset: Offset(
                kContainerBoxShadowOffsetX,
                kContainerBoxShadowOffsetY,
              ),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: selectedDateRange,
          icon: const Icon(Icons.arrow_downward),
          iconSize: kIconSize,
          iconEnabledColor: kIconColor,
          elevation: kDropdownElevation,
          dropdownColor: kDropdownColor,
          underline: Container(),
          style: const TextStyle(
            color: kTextColor,
            fontSize: kTextFontSize,
            fontWeight: kTextFontWeight,
          ),
          onChanged: onChanged,
          isExpanded: true,
          items: ['Today', 'This Week', 'This Month']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
