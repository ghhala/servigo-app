import 'package:flutter/material.dart';

class PriceRangeSlider extends StatelessWidget {
  final RangeValues values;
  final Function(RangeValues) onChanged;

  const PriceRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
  });

  static const primary = Color(0xFF6C5CE7);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'price (SYP)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${values.start.toInt()} SYP',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              '${values.end.toInt()} SYP',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: 0,
          max: 100000,
          divisions: 20,
          activeColor: primary,
          inactiveColor: Colors.grey.shade200,
          labels: RangeLabels(
            '${values.start.toInt()}',
            '${values.end.toInt()}',
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}