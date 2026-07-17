import 'dart:math' as math;
import 'package:flutter/material.dart';


class WaitingApprovalDialog extends StatelessWidget {
  const WaitingApprovalDialog({super.key, this.onOk});

  final VoidCallback? onOk;

  static const Color _color = Color(0xFFFFA726);

  
  static Future<void> show(BuildContext context, {VoidCallback? onOk}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WaitingApprovalDialog(onOk: onOk),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 90,
              height: 90,
              child: CustomPaint(painter: _DashedClockPainter(color: _color)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Waiting!',
              style: TextStyle(
                color: _color,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Your request has been submitted. Please await management approval.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onOk?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// يرسم دائرة متقطعة (dashed circle) مع عقارب ساعة، لمحاكاة أيقونة الـ Waiting
/// من الفيجما بدون الحاجة لأصل صورة خارجي.
class _DashedClockPainter extends CustomPainter {
  const _DashedClockPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final circlePaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const dashCount = 26;
    for (int i = 0; i < dashCount; i++) {
      final startAngle = (2 * math.pi / dashCount) * i;
      final sweep = (2 * math.pi / dashCount) * 0.55;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        false,
        circlePaint,
      );
    }

    final handPaint = Paint()
      ..color = color
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;

   
    canvas.drawLine(center, center + Offset(0, -radius * 0.55), handPaint);
  
    canvas.drawLine(
      center,
      center + Offset(radius * 0.35, radius * 0.15),
      handPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DashedClockPainter oldDelegate) => false;
}