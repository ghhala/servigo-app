import 'package:flutter/material.dart';

class RatingSelector extends StatelessWidget {
  final int? selectedRating;
  final Function(int?) onSelect;

  const RatingSelector({
    super.key,
    required this.selectedRating,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);

  final List<Map<String, dynamic>> _ratings = const [
    {'label': 'Any Rating', 'value': null},
    {'label': '2 stars & up', 'value': 2},
    {'label': '3 stars & up', 'value': 3},
    {'label': '4 stars & up', 'value': 4},
    {'label': '5 stars only', 'value': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ..._ratings.map((r) {
          final value = r['value'] as int?;
          final isSelected = selectedRating == value;
          return GestureDetector(
            onTap: () => onSelect(value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  // Radio circle
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
                  // Stars
                  if (value != null)
                    ...List.generate(
                      value,
                      (_) => const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFF4C700),
                      ),
                    ),
                  if (value != null) const SizedBox(width: 4),
                  Text(
                    r['label'] as String,
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