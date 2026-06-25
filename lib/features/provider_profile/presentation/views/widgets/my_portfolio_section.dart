import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


enum MediaType { image, video }

class PortfolioItem {
  final File file;
  final MediaType type;
  String description;

  PortfolioItem({
    required this.file,
    required this.type,
    this.description = '',
  });
}

class MyPortfolioSection extends StatefulWidget {
  
  final Function(List<PortfolioItem> items) onPortfolioChanged;

  const MyPortfolioSection({super.key, required this.onPortfolioChanged});

  @override
  State<MyPortfolioSection> createState() => _MyPortfolioSectionState();
}

class _MyPortfolioSectionState extends State<MyPortfolioSection> {
  final List<PortfolioItem> _items = [];
  final ImagePicker _picker = ImagePicker();

  static const Color _primary   = Color(0xFF6C3AE8);
  static const Color _secondary = Color(0xFF38B6FF);
  static const Color _bg        = Color(0xFFF5F4FB);
  static const Color _textDark  = Color(0xFF1A1340);
  static const Color _textMid   = Color(0xFF6B6B8A);
  static const Color _danger    = Color(0xFFE84040);

  // دالة مساعدة لتحديث الحالة وتمرير القائمة المحدثة للأعلى مباشرة
  void _updateParent() {
    widget.onPortfolioChanged(_items);
  }

  // ── Pickers ────────────────────────────────────────────────────────────

  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;
    setState(() {
      for (final x in picked) {
        _items.add(PortfolioItem(file: File(x.path), type: MediaType.image));
      }
    });
    _updateParent(); // 👈 تمرير القائمة بعد الإضافة
  }

  Future<void> _pickVideo() async {
    final XFile? picked =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() {
      _items.add(PortfolioItem(file: File(picked.path), type: MediaType.video));
    });
    _updateParent(); // 👈 تمرير القائمة بعد الإضافة
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Add to Portfolio',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _textDark)),
              const SizedBox(height: 16),
              _sheetOption(
                icon: Icons.photo_library_rounded,
                label: 'Add Photos',
                sub: 'Choose one or more images',
                color: _primary,
                onTap: () { Navigator.pop(context); _pickImages(); },
              ),
              const SizedBox(height: 10),
              _sheetOption(
                icon: Icons.videocam_rounded,
                label: 'Add Video',
                sub: 'Choose a video from gallery',
                color: _secondary,
                onTap: () { Navigator.pop(context); _pickVideo(); },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetOption({
    required IconData icon,
    required String label,
    required String sub,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: _textDark)),
                Text(sub,
                    style: const TextStyle(fontSize: 12, color: _textMid)),
              ],
            ),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: color),
          ],
        ),
      ),
    );
  }

  // ── Remove & Description ───────────────────────────────────────────────

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
    _updateParent(); // 👈 تمرير القائمة المحدثة بعد الحذف
  }

  void _editDescription(int index) {
    final ctrl = TextEditingController(text: _items[index].description);
    showDialog(
      context: context,
      builder: (_) => Dialog( // تم استبداله بـ Dialog عادي لتجنب أي تضارب ثيمات
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Description',
                  style: TextStyle(color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Describe this work...',
                  hintStyle: TextStyle(color: _textMid.withOpacity(0.6)),
                  filled: true,
                  fillColor: _bg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primary.withOpacity(0.5)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel', style: TextStyle(color: _textMid)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      setState(() => _items[index].description = ctrl.text.trim());
                      _updateParent(); // 👈 تمرير البيانات بعد تعديل الوصف
                      Navigator.pop(context);
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ── View full screen ───────────────────────────────────────────────────

  void _viewItem(int index) {
    final item = _items[index];
    if (item.type == MediaType.image) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(item.file, fit: BoxFit.contain),
              ),
              Positioned(
                top: 8, right: 8,
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
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _VideoPlayerScreen(file: item.file),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 14),
          _items.isEmpty ? _buildEmptyState() : _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_primary, _secondary]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.photo_library_rounded,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Portfolio',
                  style: TextStyle(
                      color: _textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(
                _items.isEmpty
                    ? 'Add photos & videos of your work'
                    : '${_items.length} item(s) added',
                style: const TextStyle(color: _textMid, fontSize: 12),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _showAddOptions,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_primary, _secondary]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text('Add',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return GestureDetector(
      onTap: _showAddOptions,
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _primary.withOpacity(0.25), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cloud_upload_outlined,
                  color: _primary.withOpacity(0.6), size: 30),
            ),
            const SizedBox(height: 10),
            const Text('No portfolio items yet.',
                style: TextStyle(
                    color: _textMid,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text('Tap + to add photos or videos',
                style: TextStyle(
                    color: _textMid.withOpacity(0.6), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.78,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) => _buildGridItem(index),
    );
  }

  Widget _buildGridItem(int index) {
    final item = _items[index];
    final isVideo = item.type == MediaType.video;

    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => _viewItem(index),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(14)),
                    child: isVideo
                        ? _VideoThumbnail(file: item.file)
                        : Image.file(
                            item.file,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                  ),
                ),
                if (isVideo)
                  Positioned(
                    bottom: 6, left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 12),
                          SizedBox(width: 2),
                          Text('Video',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 6, right: 6,
                  child: GestureDetector(
                    onTap: () => _removeItem(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _danger.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close_rounded,
                          color: Colors.white, size: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _editDescription(index),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(14)),
              ),
              child: item.description.isEmpty
                  ? Row(
                      children: [
                        Icon(Icons.edit_note_rounded,
                            size: 14,
                            color: _primary.withOpacity(0.6)),
                        const SizedBox(width: 4),
                        Text('Add description...',
                            style: TextStyle(
                                fontSize: 11,
                                color: _textMid.withOpacity(0.6),
                                fontStyle: FontStyle.italic)),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.description,
                            style: const TextStyle(
                                fontSize: 11,
                                color: _textDark,
                                height: 1.4),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.edit_rounded,
                            size: 12,
                            color: _primary.withOpacity(0.5)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// VIDEO THUMBNAIL WIDGET
// =============================================

class _VideoThumbnail extends StatefulWidget {
  final File file;
  const _VideoThumbnail({required this.file});

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail> {
  late VideoPlayerController _ctrl;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _ctrl = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (mounted) setState(() => _ready = true);
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return Container(
        color: Colors.black12,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _ctrl.value.size.width,
          height: _ctrl.value.size.height,
          child: VideoPlayer(_ctrl),
        ),
      ),
    );
  }
}

// =============================================
// FULL-SCREEN VIDEO PLAYER
// =============================================

class _VideoPlayerScreen extends StatefulWidget {
  final File file;
  const _VideoPlayerScreen({required this.file});

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late VideoPlayerController _videoCtrl;
  ChewieController? _chewieCtrl;

  @override
  void initState() {
    super.initState();
    _videoCtrl = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _chewieCtrl = ChewieController(
            videoPlayerController: _videoCtrl,
            autoPlay: true,
            looping: false,
            allowFullScreen: true,
            materialProgressColors: ChewieProgressColors(
              playedColor: const Color(0xFF6C3AE8),
              handleColor: const Color(0xFF38B6FF),
              bufferedColor: Colors.white30,
              backgroundColor: Colors.white12,
            ),
          );
        });
      });
  }

  @override
  void dispose() {
    _videoCtrl.dispose();
    _chewieCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Video', style: TextStyle(fontSize: 15)),
      ),
      body: Center(
        child: _chewieCtrl != null
            ? Chewie(controller: _chewieCtrl!)
            : const CircularProgressIndicator(color: Color(0xFF6C3AE8)),
      ),
    );
  }
}