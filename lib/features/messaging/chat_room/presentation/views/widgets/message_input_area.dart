import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageInputArea extends StatefulWidget {
  final Function(String content) onSendMessage;
  final Function(File image)? onSendImage;
  final Function(File video)? onSendVideo; 

  const MessageInputArea({
    Key? key,
    required this.onSendMessage,
    this.onSendImage,
    this.onSendVideo,
  }) : super(key: key);

  @override
  State<MessageInputArea> createState() => _MessageInputAreaState();
}

class _MessageInputAreaState extends State<MessageInputArea> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

 
  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null && widget.onSendImage != null) {
      widget.onSendImage!(File(picked.path));
    }
  }

  // ✅ اختيار فيديو
  Future<void> _pickVideo() async {
    final XFile? picked =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null && widget.onSendVideo != null) {
      widget.onSendVideo!(File(picked.path));
    }
  }

  // ✅ قائمة اختيار: صورة أو فيديو
  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: Color(0xFF4FC3F7)),
                title: const Text('photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam, color: Color(0xFF7E57C2)),
                title: const Text('video'),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      color: Colors.transparent,
      child: Row(
        children: [
          // ✅ زر إرفاق (صورة/فيديو)
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey, size: 28),
            onPressed: _showAttachmentOptions, // ✅ عدّل هنا
          ),

          // حقل الإدخال
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message..",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ✅ زر الإرسال
          GestureDetector(
            onTap: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                widget.onSendMessage(text);
                _controller.clear();
              }
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF4FC3F7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}