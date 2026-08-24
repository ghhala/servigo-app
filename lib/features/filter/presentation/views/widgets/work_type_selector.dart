import 'package:flutter/material.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class WorkTypeSelector extends StatelessWidget {
  final String? selectedValue;
  final Function(String) onSelect;

  const WorkTypeSelector({
    super.key,
    required this.selectedValue,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);


  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final options = [
      {'label': l.serviceTypeFixed, 'value': 'fixed'},
      {'label': l.serviceTypeMobile, 'value': 'mobile'},
      {'label': l.serviceTypeBoth, 'value': 'both'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.workType,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: options.map((o) {
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