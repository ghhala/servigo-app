import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class MyPortfolioSection extends StatefulWidget {
  final String text;
  final String subtext;
  const MyPortfolioSection({
    super.key,
    required this.text,
    required this.subtext,
  });

  @override
  State<MyPortfolioSection> createState() => _MyPortfolioSectionState();
}

class _MyPortfolioSectionState extends State<MyPortfolioSection> {
  final List<File> _portfolioImages = [];
  final ImagePicker _picker = ImagePicker();

  static const Color _primary = Color(0xFF6C3AE8);
  static const Color _secondary = Color(0xFF38B6FF);
  static const Color _bg = Color(0xFFF5F4FB);
  static const Color _textDark = Color(0xFF1A1340);
  static const Color _textMid = Color(0xFF6B6B8A);
  static const Color _danger = Color(0xFFE84040);

  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isNotEmpty) {
      setState(() {
        _portfolioImages.addAll(picked.map((x) => File(x.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() => _portfolioImages.removeAt(index));
  }

  void _viewImage(int index) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(_portfolioImages[index], fit: BoxFit.contain),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(children: []),
    );
  }
}
