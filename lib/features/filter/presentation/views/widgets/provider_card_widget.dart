import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/features/filter/domain/entities/provider_entity.dart';

class ProviderCardWidget extends StatelessWidget {
  final ProviderEntity provider;
  final VoidCallback onTap;

  const ProviderCardWidget({
    super.key,
    required this.provider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // ── صورة صاحب المهنة ──
            _buildAvatar(),
            const SizedBox(width: 12),
            // ── معلومات صاحب المهنة ──
            Expanded(child: _buildInfo()),
          ],
        ),
      ),
    );
  }

  // ── Avatar ──
  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 28.r,
      backgroundColor: const Color(0xFF6C5CE7),
      backgroundImage: provider.photo != null
          ? NetworkImage(provider.photo!)
          : null,
      child: provider.photo == null
          ? Text(
              provider.name.isNotEmpty
                  ? provider.name[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  // ── Info ──
  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الاسم + badge الإتاحة
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                provider.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildAvailabilityBadge(),
          ],
        ),
        const SizedBox(height: 3),

        // الخدمة الفرعية + نوع العمل
        Text(
          '${provider.subServiceName} · ${_workTypeLabel(provider.workType)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),

        // التقييم + السعر + الموقع
        Row(
          children: [
            // التقييم
            _buildRating(),
            const Spacer(),
            // السعر
            _buildPrice(),
          ],
        ),
        const SizedBox(height: 4),

        // الموقع
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 13,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                provider.locationName,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Availability Badge ──
  Widget _buildAvailabilityBadge() {
    final isAvailable = provider.isAvailable;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: isAvailable
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isAvailable ? 'متاح' : 'غير متاح',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isAvailable ? Colors.green.shade700 : Colors.red.shade700,
        ),
      ),
    );
  }

  // ── Rating ──
  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF4C700)),
        const SizedBox(width: 3),
        Text(
          provider.avgRating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  // ── Price ──
  Widget _buildPrice() {
    final min = _formatPrice(provider.minPrice);
    final max = _formatPrice(provider.maxPrice);
    return Text(
      '$min — $max SYP',
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6C5CE7),
      ),
    );
  }

  // ── Helpers ──
  String _workTypeLabel(String workType) {
    switch (workType.toLowerCase()) {
      case 'mobile':
        return 'Mobile';
      case 'fixed':
        return 'Fixed';
      case 'both':
        return 'Both';
      default:
        return workType;
    }
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}k';
    }
    return price.toStringAsFixed(0);
  }
}