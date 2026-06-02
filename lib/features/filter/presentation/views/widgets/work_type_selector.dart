import 'package:flutter/material.dart';

class WorkTypeSelector extends StatelessWidget {
  final String? selectedValue;
  final Function(String) onSelect;

  const WorkTypeSelector({
    super.key,
    required this.selectedValue,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);

  final List<Map<String, String>> _options = const [
    {'label': 'Fixed', 'value': 'fixed'},
    {'label': 'Mobile', 'value': 'mobile'},
    {'label': 'Both', 'value': 'both'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Work Type',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: _options.map((o) {
            final value = o['value']!;
            final isSelected = selectedValue == value;
            return GestureDetector(
              onTap: () => onSelect(value),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primary : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  o['label']!,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}