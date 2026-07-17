import 'package:flutter/material.dart';

/// بوب أب يظهر لصاحب المهنة لو الأدمن رفض حسابه، بنفس ستايل تصميم
/// "Un acceptable" الموجود في الفيجما (أيقونة حظر حمراء + زر تواصل مع الإدارة).
class AccountRejectedDialog extends StatelessWidget {
  const AccountRejectedDialog({super.key, this.onContactAdmin});

  final VoidCallback? onContactAdmin;

  static const Color _color = Color(0xFFE53935);

  /// استدعيها لو حالة الحساب rejected، مثال:
  /// AccountRejectedDialog.show(context, onContactAdmin: () { ... });
  static Future<void> show(BuildContext context, {VoidCallback? onContactAdmin}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AccountRejectedDialog(onContactAdmin: onContactAdmin),
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
            const Icon(Icons.block_rounded, color: _color, size: 80),
            const SizedBox(height: 18),
            const Text(
              'Unacceptable',
              style: TextStyle(
                color: _color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'The login request was rejected by the administration for '
              'violating the terms and conditions.',
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
                  onContactAdmin?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Contact the administration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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