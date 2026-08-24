import 'package:flutter/material.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class AvailabilitySelector extends StatelessWidget {
  final String? selectedValue;
  final Function(String) onSelect;

  const AvailabilitySelector({
    super.key,
    required this.selectedValue,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final options = [
      {'label': l.availableNow, 'value': 'available_now'},
      {'label': l.any, 'value': 'any'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.availabilityLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...options.map((o) {
          final value = o['value']!;
          final isSelected = selectedValue == value;
          return GestureDetector(
            onTap: () => onSelect(value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? primary : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),
                  if (value == 'available_now')
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  Text(
                    o['label']!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? primary : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}