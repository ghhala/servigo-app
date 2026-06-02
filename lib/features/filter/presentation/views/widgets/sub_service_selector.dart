import 'package:flutter/material.dart';
import 'package:servi_go_app/features/filter/domain/entities/sub_service_entity.dart';

class SubServiceSelector extends StatelessWidget {
  final List<SubServiceEntity> subServices;
  final int? selectedId;
  final Function(int) onSelect;

  const SubServiceSelector({
    super.key,
    required this.subServices,
    required this.selectedId,
    required this.onSelect,
  });

  static const primary = Color(0xFF6C5CE7);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Row(
          children: [
            const Text(
              'Sub Service',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Required',
                style: TextStyle(fontSize: 10, color: Colors.red.shade700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Options
        ...subServices.map((sub) {
          final isSelected = selectedId == sub.id;
          return GestureDetector(
            onTap: () => onSelect(sub.id),
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? primary.withOpacity(0.08)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? primary : Colors.grey.shade200,
                  width: isSelected ? 1.5 : 0.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? primary : Colors.grey.shade400,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    sub.name,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? primary : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.normal,
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
