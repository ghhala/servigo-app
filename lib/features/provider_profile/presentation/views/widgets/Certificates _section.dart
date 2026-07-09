import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ✅ عنصر شهادة موجود بالفعل على السيرفر
class ExistingCertificateItem {
  final int id;
  final String fileUrl;

  ExistingCertificateItem({required this.id, required this.fileUrl});
}

class CertificatesSection extends StatefulWidget {
  final Function(List<File> files) onCertificatesChanged;
  final List<ExistingCertificateItem> initialItems;
  final Function(List<int> removedIds)? onExistingItemsRemoved;

  const CertificatesSection({
    super.key,
    required this.onCertificatesChanged,
    this.initialItems = const [],
    this.onExistingItemsRemoved,
  });

  @override
  State<CertificatesSection> createState() => _CertificatesSectionState();
}

class _CertificatesSectionState extends State<CertificatesSection> {
  final List<File> _newFiles = [];
  late List<ExistingCertificateItem> _existingItems;
  final List<int> _removedExistingIds = [];
  final ImagePicker _picker = ImagePicker();

  static const Color _primary = Color(0xFF6C3AE8);
  static const Color _secondary = Color(0xFF38B6FF);
  static const Color _bg = Color(0xFFF5F4FB);
  static const Color _textDark = Color(0xFF1A1340);
  static const Color _textMid = Color(0xFF6B6B8A);
  static const Color _danger = Color(0xFFE84040);

  @override
  void initState() {
    super.initState();
    _existingItems = List.from(widget.initialItems);
  }

  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isNotEmpty) {
      setState(() => _newFiles.addAll(picked.map((x) => File(x.path))));
      widget.onCertificatesChanged(_newFiles);
    }
  }

  void _removeImage(int index) {
    setState(() => _newFiles.removeAt(index));
    widget.onCertificatesChanged(_newFiles);
  }

  void _removeExistingItem(int index) {
    setState(() {
      final removed = _existingItems.removeAt(index);
      _removedExistingIds.add(removed.id);
    });
    widget.onExistingItemsRemoved?.call(_removedExistingIds);
  }

  void _viewImage(File file) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.file(file, fit: BoxFit.contain)),
          Positioned(top: 8, right: 8, child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 18)),
          )),
        ]),
      ),
    );
  }

  void _viewExistingImage(String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(url, fit: BoxFit.contain)),
          Positioned(top: 8, right: 8, child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 18)),
          )),
        ]),
      ),
    );
  }

  bool get _isEmpty => _newFiles.isEmpty && _existingItems.isEmpty;
  int get _totalCount => _newFiles.length + _existingItems.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: _primary.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 6))]),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildHeader(),
        const SizedBox(height: 14),
        _isEmpty ? _buildEmptyState() : _buildImageGrid(),
      ]),
    );
  }

  Widget _buildHeader() {
    return Row(children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [_primary, _secondary]), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.photo_library_rounded, color: Colors.white, size: 18)),
      const SizedBox(width: 10),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('My Certificates', style: TextStyle(color: _textDark, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(_isEmpty ? 'Add certificates to showcase your skills and qualifications.' : '$_totalCount certificate(s) added', style: const TextStyle(color: _textMid, fontSize: 12)),
        ]),
      ),
      GestureDetector(
        onTap: _pickImages,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [_primary, _secondary]), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: _primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add_rounded, color: Colors.white, size: 16), SizedBox(width: 4), Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))]),
        ),
      ),
    ]);
  }

  Widget _buildEmptyState() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        height: 130, width: double.infinity,
        decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: _primary.withOpacity(0.25), width: 1.5)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: _primary.withOpacity(0.08), shape: BoxShape.circle), child: Icon(Icons.cloud_upload_outlined, color: _primary.withOpacity(0.6), size: 30)),
          const SizedBox(height: 10),
          const Text('No certificates added yet.', style: TextStyle(color: _textMid, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text('Tap + to add your certificates', style: TextStyle(color: _textMid.withOpacity(0.6), fontSize: 12)),
        ]),
      ),
    );
  }

  Widget _buildImageGrid() {
    final totalCount = _existingItems.length + _newFiles.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index < _existingItems.length) {
          final item = _existingItems[index];
          return GestureDetector(
            onTap: () => _viewExistingImage(item.fileUrl),
            child: Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(item.fileUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image))),
              Positioned(top: 4, right: 4, child: GestureDetector(
                onTap: () => _removeExistingItem(index),
                child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: _danger.withOpacity(0.85), shape: BoxShape.circle), child: const Icon(Icons.close_rounded, color: Colors.white, size: 12)),
              )),
            ]),
          );
        }
        final fileIndex = index - _existingItems.length;
        return GestureDetector(
          onTap: () => _viewImage(_newFiles[fileIndex]),
          child: Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(_newFiles[fileIndex], fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
            Positioned(top: 4, right: 4, child: GestureDetector(
              onTap: () => _removeImage(fileIndex),
              child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: _danger.withOpacity(0.85), shape: BoxShape.circle), child: const Icon(Icons.close_rounded, color: Colors.white, size: 12)),
            )),
          ]),
        );
      },
    );
  }
}