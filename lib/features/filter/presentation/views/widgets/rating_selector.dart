import 'package:flutter/material.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class RatingSelector extends StatelessWidget {
  final int? selectedRating;
  final Function(int?) onSelect;

  const RatingSelector({
    super.key,
    required this.selectedRating,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final ratings = [
      {'label': l.anyRating, 'value': null},
      {'label': l.rating2AndUp, 'value': 2},
      {'label': l.rating3AndUp, 'value': 3},
      {'label': l.rating4AndUp, 'value': 4},
      {'label': l.rating5Only, 'value': 5},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.ratingLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...ratings.map((r) {
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